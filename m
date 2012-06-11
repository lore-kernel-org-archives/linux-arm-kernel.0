From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Jun 2012 09:15:20 +0100
Subject: v3.4 boot failure on qemu-system-arm -M versatilepb
In-Reply-To: <XNM1$5$0$1$$3$9$0$A$8005415U4fc63e90@hitachi.com>
References: <XNM1$5$0$1$$3$9$0$A$8005401U4fc38a01@hitachi.com>
 <4FC52B61.2000604@gmail.com>
 <XNM1$5$0$1$$3$9$0$A$8005413U4fc5e967@hitachi.com>
 <XNM1$5$0$1$$3$9$0$A$8005415U4fc63e90@hitachi.com>
Message-ID: <4FD5A918.7040200@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/12 16:37, takuo.koguchi.sw at hitachi.com wrote:
> Hi Rob,
>
> I am sorry that it seems I gave you wrong information.
>
> It turned out that the config I used was not versatile_defconfig.
> I have tried to reproduce with versatile_defconfig and found that IO_SPACE_LIMIT modification has no effect, ie. it cannot mount root=/dev/sdb even if IO_SPACE_LIMIT is 0xffffffff. I suppose it misses the driver to read /dev/sdb.
>
> Actual config I used derived from buildroot tool's board/qemu/arm-versatile/linux-3.3.config. ( It works fine for linux-3.3 )
> I attached my .config.
> As for this config, #define IO_SPACE_LIMIT ((resource_size_t)0xffffffff) works for linux-3.4 to mount /dev/sdb as rootfs.
>
> The command line I used was as follows,
> $ sudo qemu-system-arm -M versatilepb -kernel ~/linux/arch/arm/boot/zImage -net nic,vlan=0 -net tap,vlan=0,ifname=tap0,script=no,downscript=no -hda output/images/rootfs.ext2 -append "console=ttyAMA0 root=/dev/sda ip=192.168.7.3::192.168.7.1:255.255.255.0"
>
> Best Regards,
>
> Takuo Koguchi

We've seen the same problem. Limiting the __io() to the IO_SPACE_LIMIT
will not fix the problem as the previous code was using a 1:1 CPU to
PCI space view (which is why it was allocating space at 0x44000000).

Either the __io() macro needs to add the base of PCI space, or the
limit needs to be restored.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
