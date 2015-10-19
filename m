From: sophian.yoma@gmail.com (yoma sophian)
Date: Mon, 19 Oct 2015 17:55:29 +0800
Subject: some question about LR of task_pt_regs
Message-ID: <CADUS3o=F4diU-xG8DsE6c+Zm6juQetJ0kmMtKNdz8pOXBRxq=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
I use linaro toolchain which libc is compile in thumb mode and if any
user mode program call sleep, the lr of its task_pt_regs will be 0, no
matter how many function level I called.

Would anyone let me know where the source code that updates LR of
task_pt_regs in arm?

appreciate your kind help in advancd,

Below are environments and experiments I did:
a. I use below linaro toolchain to compile a user mode program.
https://releases.linaro.org/14.08/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.9-2014.08_linux.tar.xz
b. my kerenl is 3.10
c. my cpu is cortexA9 mp core.

I did below things in a simple user mode program:
1. create a child thread
2. both parent and child do the while loop to sleep like below
function call depth
(I purposely use 2 level call function before sleep)

void go_to_sleep_lv2(void)
{
  printf( "%s \n",__func__);
  while(1) {
        sleep(30);
  }
}
void go_to_sleep_lv1(void)
{
        printf( "%s \n",__func__);
        go_to_sleep_lv2();
}
void * simple_thread_1(void * dummy)
{
        go_to_sleep_lv1();
        return NULL;
}
int main()
{
        int error;
        pthread_t tid0 = 0;
        error = pthread_create(&tid0, 0, &simple_thread_1, 0);
        assert(error == 0);
        while(1){
                go_to_sleep_lv1();
        }
        error = pthread_join(tid0, NULL);
        assert(error == 0);
        return 0;
}


I found the lr of parent and child task_pt_regs are all 0 with below
print patch I add in kernel.

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 3ee4d06..3fff0fe 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1646,7 +1646,10 @@ SYSCALL_DEFINE2(nanosleep, struct timespec
__user *, rqtp,
                struct timespec __user *, rmtp)
 {
        struct timespec tu;
-
+       struct pt_regs *regs;
+       regs = task_pt_regs(current);
+       printk(KERN_ERR"calling %s, current->pid = %d, current->common
=%s regs->ARM_lr= 0x%lx\n", __func__, current->pid,
current->comm,regs->ARM_lr)
        if (copy_from_user(&tu, rqtp, sizeof(tu)))
                return -EFAULT;

the kernel output like below:
[ 1961.298882] calling SYSC_nanosleep, current->pid = 1248,
current->common =simple.thread regs->ARM_lr= 0x0

I found something instresting:
1. the toolchain's libc is build in thumb mode.
2. if I change while loop like belwo without calling sleep.like below,
the LR of task_pt_regs will be not 0.

void go_to_sleep_lv2(void)
{
  printf( "%s \n",__func__);
  while(1);
}
