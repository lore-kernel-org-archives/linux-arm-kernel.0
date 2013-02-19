From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Tue, 19 Feb 2013 10:11:09 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
Message-ID: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently IPC SHM works in a strange way on ARM:
the syscall sys_shmat() requires the argument shmaddr
be SHMLBA-aligned (ARM has the macro __ARCH_FORCE_SHMLBA
unconditionally defined) but allocates memory that
isn't SHMLBA-aligned because the value of memory alignment
depends on presense of certain cache aliases.

Such a behavior raises the following problem. Consider
the program:

static int p[2];
static pid_t task2_pid;

static int task1()
{
	int task2_status;
	int *n;
	int shmid;

	shmid = shmget(0x94646337, 40960, IPC_CREAT);
	if (shmid < 0) {
		perror("Failed to get a SHM descriptor");
		return 10;
	}

	n = (int*)shmat(shmid, 0, 0);
	if (n == (int*)-1) {
		perror("task1: failed to attach the SHM segment");
		return 11;
	}

	*n = MAGIC;

	shmdt(n);

	if (write(p[1], &n, sizeof(n)) != sizeof(n))
	{
		perror("task1: failed to send the SHM address");
		return 12;
	}

	if (waitpid(task2_pid, &task2_status, 0) != task2_pid)
	{
		perror("task2: failed to wait for task2");
		return 13;
	}

	if (!WIFEXITED(task2_status))
	{
		printf("task1: task2 hasn't exited!\n");
		return 14;
	}

	printf("task1: task2 exited with code %d, "
		"the SHM was attached to %p.\n",
		WEXITSTATUS(task2_status), n);

	return 0;
}

static int task2()
{
	int *n = 0;
	int res;
	void *addr;
	int shmid;

	shmid = shmget(0x94646337, 40960, IPC_CREAT);
	if (shmid < 0) {
		perror("Failed to get a SHM descriptor");
		return 20;
	}

	if (read(p[0], &n, sizeof(n)) != sizeof(n))
	{
		perror("task2: failed to receive the SHM address");
		return 21;
	}

	addr = shmat(shmid, n, 0);
	if (addr == (void*)-1)
	{
		printf("task2: failed to attach the SHM to the address %p: %s\n",
			n, strerror(errno));
		res = 22;
		goto exit_task2;
	}

	if ((void*)n != addr)
	{
		printf("task2: the SHM isn't attached where it's expected:"
				"expected %p, got %p\n", n, addr);
		res = 23;
		goto exit_task2;
	}

	if (*n != MAGIC)
	{
		printf("task2: *n (%d) isn't %d\n", *n, MAGIC);
		res = 24;
		goto exit_task2;
	}

exit_task2:
	shmdt(addr);

	return res;
}

int main()
{
	int res = 0;

	if (pipe(p) < 0)
	{
		perror("Failed to create a pipe");
		return 2;
	}

	task2_pid = fork();
	if (task2_pid)
		res = task1();
	else
		res = task2();

	close(p[0]);
	close(p[1]);

	return res;
}

This program sometimes fails generating the output like that:

root at test:~/shmfail# ./shmfail
task2: failed to attach the SHM to the address 0xb6e3a000: Invalid argument
task1: task2 exited with code 22, the SHM was attached to 0xb6e3a000.

root at test:~/shmfail# ./shmfail
task2: failed to attach the SHM to the address 0xb6e63000: Invalid argument
task1: task2 exited with code 22, the SHM was attached to 0xb6e63000.

and sometimes succeeds:

root at test:~/shmfail# ./shmfail
task1: task2 exited with code 0, the SHM was attached to 0xb6e94000.

The problem is reproducible in the mainstream kernel branch as well as
in a stable (3.7.5) kernel release. The program isn't reproducible on x86_64.

As you can see the program fails when the address returned by
the function shmat() isn't SHMLBA-aligned.

This patch makes file-mmapped memory be unconditionaly
SHMLBA-aligned.

Signed-off-by: Alexander Kartashov <alekskartashov@parallels.com>
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Cyrill Gorcunov <gorcunov@openvz.org>
CC: Pavel Emelyanov <xemul@parallels.com>
---
 arch/arm/mm/mmap.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 10062ce..eca577e3 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -65,8 +65,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	 * We only need to do colour alignment if either the I or D
 	 * caches alias.
 	 */
-	if (aliasing)
-		do_align = filp || (flags & MAP_SHARED);
+	do_align = filp || (flags & MAP_SHARED);
 
 	/*
 	 * We enforce the MAP_FIXED case.
-- 
1.7.9.5
