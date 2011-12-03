From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat,  3 Dec 2011 06:42:02 +0100
Subject: [PATCH v2] sanbox: add linux_execve and linux_exec command
Message-ID: <1322890922-32341-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will allow to execute a program of the host from barebox

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
v2:

	fix missing free

Best Regards,
J.
 arch/sandbox/mach-sandbox/include/mach/linux.h |    2 +
 arch/sandbox/os/common.c                       |   22 +++++++++
 commands/Kconfig                               |    4 ++
 commands/Makefile                              |    1 +
 commands/linux_exec.c                          |   60 ++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 commands/linux_exec.c

diff --git a/arch/sandbox/mach-sandbox/include/mach/linux.h b/arch/sandbox/mach-sandbox/include/mach/linux.h
index 7c2386d..5917fe9 100644
--- a/arch/sandbox/mach-sandbox/include/mach/linux.h
+++ b/arch/sandbox/mach-sandbox/include/mach/linux.h
@@ -10,6 +10,8 @@ ssize_t linux_write(int fd, const void *buf, size_t count);
 off_t linux_lseek(int fildes, off_t offset);
 int linux_tstc(int fd);
 
+int linux_execve(const char * filename, char *const argv[], char *const envp[]);
+
 int barebox_register_console(char *name_template, int stdinfd, int stdoutfd);
 
 struct linux_console_data {
diff --git a/arch/sandbox/os/common.c b/arch/sandbox/os/common.c
index 1c5ae5d..34db022 100644
--- a/arch/sandbox/os/common.c
+++ b/arch/sandbox/os/common.c
@@ -45,6 +45,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <sys/select.h>
+#include <sys/wait.h>
 /*
  * ...except the ones needed to connect with barebox
  */
@@ -185,6 +186,27 @@ off_t linux_lseek(int fd, off_t offset)
 	return lseek(fd, offset, SEEK_SET);
 }
 
+int linux_execve(const char * filename, char *const argv[], char *const envp[])
+{
+	pid_t pid, tpid;
+	int execve_status;
+
+	pid = fork();
+
+	if (pid == -1) {
+		perror("linux_execve");
+		return pid;
+	} else if (pid == 0) {
+		exit(execve(filename, argv, envp));
+	} else {
+		do {
+			tpid = wait(&execve_status);
+		} while(tpid != pid);
+
+		return execve_status;
+	}
+}
+
 extern void start_barebox(void);
 extern void mem_malloc_init(void *start, void *end);
 
diff --git a/commands/Kconfig b/commands/Kconfig
index c2492fa..978cc67 100644
--- a/commands/Kconfig
+++ b/commands/Kconfig
@@ -107,6 +107,10 @@ config CMD_TIME
 	  checking for ctrl-c, so the time command can be used with commands
 	  which are interruptible with ctrl-c.
 
+config CMD_LINUX_EXEC
+	bool "linux exec"
+	depends on LINUX
+
 endmenu
 
 menu "file commands                 "
diff --git a/commands/Makefile b/commands/Makefile
index f82dcfa..e4e94fb 100644
--- a/commands/Makefile
+++ b/commands/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_CMD_USB)		+= usb.o
 obj-$(CONFIG_CMD_TIME)		+= time.o
 obj-$(CONFIG_CMD_OFTREE)	+= oftree.o
 obj-$(CONFIG_CMD_MAGICVAR)	+= magicvar.o
+obj-$(CONFIG_CMD_LINUX_EXEC)	+= linux_exec.o
diff --git a/commands/linux_exec.c b/commands/linux_exec.c
new file mode 100644
index 0000000..00c7e80
--- /dev/null
+++ b/commands/linux_exec.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <common.h>
+#include <command.h>
+#include <mach/linux.h>
+
+static int do_linux_exec(struct command *cmdtp, int argc, char *argv[])
+{
+	int ret;
+	char **newargv;
+	char *newenv[] = { NULL };
+	int i, j;
+
+	if (argc < 2)
+		return 1;
+
+	newargv = xzalloc(sizeof(char*) * argc);
+
+	for (j = 0, i = 1; i < argc; i++, j++)
+		newargv[j] = argv[i];
+
+	newargv[j] = NULL;
+	ret = linux_execve(argv[1], newargv, newenv);
+
+	free(newargv);
+
+	if (ret)
+		return 1;
+
+	return 0;
+}
+
+BAREBOX_CMD_HELP_START(linux_exec)
+BAREBOX_CMD_HELP_USAGE("linux_exec ...\n")
+BAREBOX_CMD_HELP_SHORT("Execute a command on the host\n")
+BAREBOX_CMD_HELP_END
+
+BAREBOX_CMD_START(linux_exec)
+	.cmd		= do_linux_exec,
+	.usage		= "Execute a command on the host",
+	BAREBOX_CMD_HELP(cmd_linux_exec_help)
+BAREBOX_CMD_END
-- 
1.7.7
