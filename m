From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Feb 2013 09:39:05 +0000
Subject: [PATCH 2/4] ARM: tegra: pmc: add power on function for
 secondary CPUs
In-Reply-To: <1361604480.1804.59.camel@jlo-ubuntu-64.nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-3-git-send-email-josephl@nvidia.com>
 <5127BAD2.8030904@wwwdotorg.org>
 <1361604480.1804.59.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <20130223093905.GF17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 23, 2013 at 03:28:00PM +0800, Joseph Lo wrote:
> On Sat, 2013-02-23 at 02:37 +0800, Stephen Warren wrote:
> > On 02/21/2013 11:44 PM, Joseph Lo wrote:
> > > +	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
> > > +	if (IS_ERR_VALUE(id))
> > > +		return false;
> > 
> > As I pointed out downstream, that should be if (id < 0); IS_ERR_VALUE is
> > intended for use on error-pointers, not on integer error codes.
> 
> IS_ERR is for error pointers, IS_ERR_VALUE is for error return code,
> isn't it?

No.  Just because there's a macro somewhere doesn't mean it should be used.

The err.h stuff is only there to deal with functions which can return
kernel pointer values and error values, and resolve the conflict between
negative integers and pointers which also appear to be negative integers.

If you don't have that conflict, then making use of err.h is pointless
and is pure obfuscation.

So, just use the plain:

	if (id < 0)
		return false;

here.
