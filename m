From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 26 Apr 2010 12:03:29 +0300
Subject: [PATCH 0/2] kexec-tools: ARM kernel crashdump support
Message-ID: <cover.1272271391.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These patches bring ARM kernel crashdump support for kexec-tools. They need
kernel support which was posted on LAKML while ago[1]. I should've sent them
both at the same time so that people actually could try them but apparently I
didn't. Sorry about that. I can sent the whole series again if preferred.

Only zImage format is currently supported.

In addition, I have modified sample gdb macros from
kernel/Documentation/kdump/gdbmacrox.txt to work with ARM crashdumps. They are
included in the end of this email in case someone finds them useful.

I have been testing these on my N900.

Thanks,
MW

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/013245.html

Mika Westerberg (2):
  kexec: add phys_offset field
  kexec: implement ARM crashdump support

 kexec/arch/arm/Makefile           |    1 +
 kexec/arch/arm/crashdump-arm.c    |  318 +++++++++++++++++++++++++++++++++++++
 kexec/arch/arm/crashdump-arm.h    |   19 +++
 kexec/arch/arm/kexec-arm.c        |    5 -
 kexec/arch/arm/kexec-zImage-arm.c |   47 +++++-
 kexec/crashdump-elf.c             |    9 +-
 kexec/crashdump.h                 |    1 +
 7 files changed, 392 insertions(+), 8 deletions(-)
 create mode 100644 kexec/arch/arm/crashdump-arm.c
 create mode 100644 kexec/arch/arm/crashdump-arm.h

------------------------- ~/.gdbinit -------------------------
#
# Useful gdb macros for ARM kdumps. Derived from macros
# in Documentation/kdump/gdbmacros.txt.
#
# Credits:
# Alexander Nyberg <alexn@telia.com>
# V Srivatsa <vatsa@in.ibm.com>
# Maneesh Soni <maneesh@in.ibm.com>
# Mika Westerberg <ext-mika.1.westerberg@nokia.com>
#

define arch_current_thread_info
	set $current_thread_info = \
		(struct thread_info *)((unsigned long)$sp & ~(8192-1))
end

define current
	arch_current_thread_info

	set $current = $current_thread_info->task
end

define ps
	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
	set $init_t=&init_task
	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)

	# get current task
	current

	printf "PID        COMMAND              TASK\n"

	while ($next_t != $init_t)
		set $next_t=(struct task_struct *)$next_t

		printf "%-10d %-20s 0x%x", $next_t->pid, $next_t->comm, $next_t
		if ($next_t == $current)
			printf "*\n"
		else
			printf "\n"
		end

		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
	end
end

define dmesg
	set $i = 0
	set $end_idx = (log_end - 1) & (log_buf_len - 1)

	while ($i < logged_chars)
		set $idx = (log_end - 1 - logged_chars + $i) & (log_buf_len - 1)

		if ($idx + 100 <= $end_idx) || \
		   ($end_idx <= $idx && $idx + 100 < log_buf_len)
			printf "%.100s", &log_buf[$idx]
			set $i = $i + 100
		else
			printf "%c", log_buf[$idx]
			set $i = $i + 1
		end
	end
end
document dmesg
	print the kernel ring buffer
end

define lsfs
	set $fs = file_systems

	while ($fs != 0)
		printf "%-20s %p\n", $fs->name, $fs
		set $fs = $fs->next
	end
end
document lsfs
	prints registered filesystems
end

define print_mount_path
	if ($arg0 != $arg1->d_parent)
		print_mount_path $arg0->d_parent $arg1
	end
	if ($arg0->d_name.name[0] != '/')
		printf "/%s", $arg0->d_name.name
	end
end

define print_mount
	if ($arg0 != $arg1)
		print_mount $arg0->mnt_parent $arg1
	end

	print_mount_path $arg0->mnt_mountpoint $arg0->mnt_mountpoint->d_parent
end

define mounts
	current
	set $vfsmount_off=((size_t)&((struct vfsmount *)0)->mnt_list)
	set $root = $current->nsproxy->mnt_ns->root
	set $r_prev = $root->mnt_list.prev
	set $r_next = $root->mnt_list.next
	set $mnt=(struct vfsmount *)((char *)($r_next) - $vfsmount_off)
	while ($r_next != $r_prev)
		printf "%-20s %p %-10s ", $mnt->mnt_devname, $mnt, $mnt->mnt_sb->s_id
		if ($mnt->mnt_parent == $root)
			printf "/"
		else
			print_mount $mnt $root
		end
		printf "\n"

		set $r_next = $mnt->mnt_list.next
		set $mnt=(struct vfsmount *)((char *)($r_next) - $vfsmount_off)
	end
end
document mounts
	prints out all mounts
end
