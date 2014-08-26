From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 26 Aug 2014 16:50:21 -0400
Subject: Generic communication of boot loader state to the OS
In-Reply-To: <20140826190230.GX30401@n2100.arm.linux.org.uk>
References: <CAKON4Oz-PRgXyNKj=T9ymzOOhCMPjBMdYdE1Mr1CHWv3boskiw@mail.gmail.com>
 <20140826182816.GW30401@n2100.arm.linux.org.uk>
 <CAKON4Oy7SU9kj=DdJ+Oq14ukL7kHP7Qn9bPrQ3PKUL6ZJww=gw@mail.gmail.com>
 <20140826190230.GX30401@n2100.arm.linux.org.uk>
Message-ID: <CAKON4OwG2XfGYv+BMqMStWvAf_K_AYdarhpQQw3FLHWE+D8Sxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 3:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 26, 2014 at 02:39:45PM -0400, jonsmirl at gmail.com wrote:
>> On Tue, Aug 26, 2014 at 2:28 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Aug 26, 2014 at 12:10:00PM -0400, jonsmirl at gmail.com wrote:
>> >> As a side effect this will eliminate the need for kernel command line
>> >> parameters describing boot state. Like console="". Over time it might
>> >> even be able to pass a DHCP IP address from uboot into the kernel.
>> >
>> > Err no.  Don't even think about that.  DHCP may be wonderful and all,
>> > but there's a fundamental issue with it: entries time out unless they
>> > are renewed.
>> >
>> > Why is that a problem?  Well, take a DHCP server which hands out
>> > dynamic addresses, and updates the DNS.  When the lease expires, it
>> > tears down the DNS entry.
>> >
>> > Now take a target booting using DHCP in uboot, which then mounts its
>> > root NFS.  If it tries to startup a DHCP client, the first thing the
>> > DHCP client does is to clean up the interface... resulting in it
>> > killing the root NFS connection.  If that doesn't happen, then you
>> > end up with a problem at shutdown, because DHCP clients always
>> > deconfigure the interface when they're killed off - resulting in
>> > "reboot" not being functional.
>>
>> I run the same configuration  -  uboot in flash, tftp to load kernel,
>> nfs mount the root. And I do reboot fifty times a day too.  I just put
>> everything on static IPs to avoid problems.
>>
>> Would this work if the DHCP client was notified that there already was
>> an IP lease in place?  It could remember that lease and then be
>> responsible for setting it into the interface and renewing it. Right
>> now there is no way to pass this information.
>>
>> Doesn't the DHCP client do the wrong thing simply because it lacks the
>> info to do something better?
>
> It can get the already configured IP address if the kernel (or initramfs)
> has already configured the interface - it's already available from the
> interface itself.  So it's not that there's no way to pass this to DHCP,
> it's that DHCP always starts out assuming that it's the new kid on the
> block.
>
> Solving that problem doesn't get away from the shutdown problem though.
> You can partially avoid it by not having interfaces brought down, but
> one of the things that distros commonly do is kill all processes during
> shutdown... which kills the DHCP client, and then causes the interface
> to be deconfigured... which then stalls the reboot operation because
> suddenly the root-NFS server is no longer available... Gosh, why did
> that happen I wonder...

I wonder if DHCP client couldn't be replaced with a udev event. Set a
timer in the kernel for the length of the lease. Then generate a udev
event when it is ready to expire. Udev event runs an app that gets a
new lease.  Now there is no process to kill on reboot and everyone is
happy.



>
> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.



-- 
Jon Smirl
jonsmirl at gmail.com
