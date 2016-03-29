From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Mar 2016 01:52:16 +0300
Subject: arm64: kernel v4.6-rc1 hangs on QEMU
In-Reply-To: <3334343.7r57EH3qRj@wuerfel>
References: <20160329220502.GA14443@yury-N73SV> <3753214.GGjb33ZPlQ@wuerfel>
 <20160329222217.GA31869@yury-N73SV> <3334343.7r57EH3qRj@wuerfel>
Message-ID: <20160329225216.GB31869@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 12:32:42AM +0200, Arnd Bergmann wrote:
> On Wednesday 30 March 2016 01:22:17 Yury Norov wrote:
> > > 
> > > Undefined instruction in cpuinfo_store_boot_cpu() could be related
> > > to the SYS_ID_AA64MMFR2_EL1 access that was recently added.
> > > 
> > > What does the architecture say about reading unknown cpuid registers?
> > > 
> > >       Arnd
> > 
> > ThunderX has some unimplemented system registers. AFAIR, attempt to access it
> > causes data abort.
> 
> Ok, if that is the case, maybe the read_cpuid() macro can be changed
> so it contains a fixup for the trap? That should handle both data abort
> and undefinstr.
> 
> 	Arnd

Sounds alluring, but not clear what we'd return that way. I mean, how
we'd distinguish between correct value and error code (0, -1 or whatever).
But I think, we can do like this:

        val = read_cpuid_safe(reg, impossible_val);
        if (val == impossible_val)
                goto err;

I think it will work for many cases.

Yury.
