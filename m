From: koyo.take@gmail.com (Koyo Takenoshita)
Date: Mon, 18 Jan 2010 22:35:26 +0900
Subject: ioctl() returns EFAULT / MMU domain problem?
Message-ID: <ac4446ac1001180535u299fa2f8rc2fdb3317a566066@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm testing OSS function on my i.MX25 board.

I get ioctl(fd, SNDCTL_DSP_GETBLKSIZE, &size) returns -EFAULT in rare
case.

In kernel code, copy_to_user in snd_pcm_hw_params_user was failed when
ioctl returns -EFAULT.

The second argment of the copy_to_user() is an address of kernel
region which allocated by kmalloc at snd_pcm_oss_change_params. So
that, the kernel domain's access type is set to manager mode at
snd_pcm_kernel_ioctl by set_fs(KERNEL_DS) before copy_to_user is
called.

I checked CP15 domain register when copy_to_user was failed, then the
value was 0x15. It means that kernel domain's access type is client
mode.

I think that the problem is that there is a possibility of schedule
while doing set_fs(KERNEL_DS) and copy_to_user.

No one has same problem?

Thanks,
Koyo
