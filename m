From: james.morse@arm.com (James Morse)
Date: Thu, 12 Oct 2017 12:40:35 +0100
Subject: kdump: need help with kexec -p
In-Reply-To: <HE1PR04MB12416F54193B1A61BC0652ED974A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
References: <HE1PR04MB12416F54193B1A61BC0652ED974A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
Message-ID: <59DF54B3.1050404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

(+CC: Akashi Takahiro, who wrote the arm64 kdump support)

On 11/10/17 10:11, Prabhakar Kushwaha wrote:
> We are facing some issues while using  kexec -p on ARM64 NXP platforms. 
>
> 1) After calling kexec -p, if immediately "panic" is triggered the crash kernel
> does not boot. If we run few commands and wait for atleast (20-30 secs), before
> triggering the panic, the crash kernel boots.

What kernel version do you see this on? Can you log the kernel output in each
case, (do you get a 'bye' message even when the new kernel doesn't boot).

Does 'kexec -p' report success in both cases? ($? == 0)


kdump can take many seconds in purgatory, it checksums the kdump image to check
it didn't get corrupted between 'kexec -p' and crash time, but it doesn't sound
like this is what you're seeing.


> 2) We do not see the issue ("1" ), when we do umount -a, before calling the panic
> after kexec-p.

What filesystems (ext4, nfs etc) do you have mounted, and which ones does
'umount -a' get rid of?
Where are these filesystems stored?

How many CPUs does your platform have?

(...does crashing on a different CPU change the behaviour?)
> taskset -c 1 bash -c "echo c > /proc/sysrq-trigger"


> The issue does not seem to pertain to the NXP software it seems.   (because this
> observation has been observed on very simple kernel, where most of the
> controllers have been removed from device tree).

> Also found some info related to this on  internet where it is mentioned that
> without un-mounting the mounted filesystems, the boot of next kernel is not
> recommended. (this is in context of kexec -e though)
> https://www.linux.com/news/reboot-racecar-kexec.

This is because the filesystem is marked as mounted on-disk, and there may be
vital data you've written but hasn't made it to the disk yet.

For 'kexec -e' I think it tries to shutdown and reboot, then jumps to the new
kernel instead of calling the firmware. This means all filesystems should be
sync()d, umounted or at least remounted read-only.

For kdump, we've already crashed, so you've already lost data. Its a best effort
can we get to a point where you can debug the original crash.


Thanks,

James
