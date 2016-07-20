From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jul 2016 09:35:30 +0100
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <8a8b2909-7f95-03e4-bf8e-dd29b5fc1fba@gmail.com>
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
 <20160713130338.GB16900@redhat.com>
 <20160713174009.GA1041@n2100.armlinux.org.uk>
 <20160713182247.GA25232@redhat.com>
 <1468845964.2800.3.camel@gmail.com>
 <20160718132629.GB32512@redhat.com>
 <8a8b2909-7f95-03e4-bf8e-dd29b5fc1fba@gmail.com>
Message-ID: <20160720083530.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 01:45:42PM +1000, Balbir Singh wrote:
> > IOW, if your kernel forced signature verification, you should not be
> > able to do sig_enforce=0. If you kernel did not have
> > CONFIG_MODULE_SIG_FORCE=y, then sig_enforce should be 0 by default anyway
> > and you are not making it worse using command line.
> 
> OK.. I checked and you are right, but that is an example and there are
> other things like security=, thermal.*, nosmep, nosmap that need auditing
> for safety and might hurt the system security if used. I still think
> think that assuming you can pass any command line without breaking security
> is a broken argument.

Quite, and you don't need to run code in a privileged environment to do
any of that.

It's also not trivial to protect against: new kernels gain new arguments
which older kernels may not know about.  No matter how much protection
is built into older kernels, newer kernels can become vulnerable through
the addition of further arguments.

Also, how sure are we that there are no stack overflow issues with kernel
command line parsing?  Can we be sure that there's none?  This is
something which happens early in the kernel boot, before the full memory
protections have been set up.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
