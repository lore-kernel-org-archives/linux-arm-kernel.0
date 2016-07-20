From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 20 Jul 2016 12:50:11 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <34243612.Gid3QHG1hd@wuerfel>
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160720083530.GK1041@n2100.armlinux.org.uk> <34243612.Gid3QHG1hd@wuerfel>
Message-ID: <2545578.SWp0m9VQX8@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 20 Juli 2016, 13:12:20 schrieb Arnd Bergmann:
> On Wednesday, July 20, 2016 8:47:45 PM CEST Michael Ellerman wrote:
> > At least for stdout-path, I can't really see how that would
> > significantly help an attacker, but I'm all ears if anyone has ideas.
> 
> That's actually an easy one that came up before: If an attacker controls
> a tty device (e.g. network console) that can be used to enter a debugger
> (kdb, kgdb, xmon, ...), enabling that to be the console device
> gives you a direct attack vector. The same thing will happen if you
> have a piece of software that intentially gives extra rights to the
> owner of the console device by treating it as "physical presence".

I think people are talking past each other a bit in these arguments about 
what is relevant to security or not.

For the kexec maintainers, kexec_file_load has one very specific and narrow 
purpose: enable Secure Boot as defined by UEFI.

And from what I understand of their arguments so far, there is one and only 
one security concern: when in Secure Boot mode, a system must not allow 
execution of unsigned code with kernel privileges. So even if one can 
specify a different root filesystem and do a lot of nasty things to the 
system with a rogue userspace in that root filesystem, as long as the kernel 
won't load unsigned modules that's not a problem as far as they're 
concerned.

Also, AFAIK attacks requiring "physical presence" are out of scope for the 
UEFI Secure Boot security model. Thus an attack that involves control of a 
console of plugging an USB device is also not a concern.

One thing I don't know is whether an attack involving a networked IPMI 
console or a USB device that can be "plugged" virtually by a managing system 
(BMC) is considered a physical attack or a remote attack in the context of 
UEFI Secure Boot.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
