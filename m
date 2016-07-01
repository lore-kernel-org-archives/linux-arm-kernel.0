From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 01 Jul 2016 12:46:31 -0300
Subject: [RFC] arm64: kexec_file_load support
In-Reply-To: <20160701051111.GL20774@linaro.org>
References: <20160701051111.GL20774@linaro.org>
Message-ID: <3300473.zhbeG65qgA@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 01 Juli 2016, 14:11:12 schrieb AKASHI Takahiro:
> I'm not sure whether there is any demand for kexec_file_load
> support on arm64, but anyhow I'm working on this and now
> my early prototype code does work fine.

It is necessary if you want to support loading only signed kernels, and also 
if you want IMA to measure the kernel in its event log.

> There is, however, one essential issue:
> While arm64 kernel requires a device tree blob to be set up
> correctly at boot time, the current system call API doesn't
> have this parameter.
>     int kexec_file_load(int kernel_fd, int initrd_fd,
>                         unsigned long cmdline_len, const char
> *cmdline_ptr, unsigned long flags);
> 
> Should we invent a new system call, like kexec_file_load2,
> and, if so, what kind of interface would be desired?

I'm facing the same issue on powerpc. What I'm doing is taking the device 
tree that was used to boot the current kernel and modifying it as necessary 
to pass it to the next kernel.

I agree that it would be better if we could have a system call where a 
custom device tree could be passed. One suggestion is:


kexec_file_load2(int fds[], int fd_types[], int nr_fds,
		 unsigned long cmdline_len, const char *cmdline_ptr,
		unsigned long flags);

Where fds is an array with nr_fds file descriptors and fd_types is an array 
specifying what each fd in fds is. So for example, if fds[i] is the kernel, 
then fd_types[i] would have the value KEXEC_FILE_KERNEL_FD. If fds[i] is the 
device tree blob, fd_types[i], would have the value KEXEC_FILE_DTB and so 
on. That way, the syscall can be extended for an arbitrary number and types 
of segments that have to be loaded, just like kexec_load.

Another option is to have a struct:

kexec_file_load2(struct kexec_file_params *params, unsigned long params_sz);

Where:

struct kexec_file_params {
	int version;	/* allows struct to be extended in the future */
	int fds[];
	int fd_types[];
	int nr_fds;
	unsigned long cmdline_len;
	const char *cmdline_ptr;
	unsigned long flags;
};

This is even more flexible.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
