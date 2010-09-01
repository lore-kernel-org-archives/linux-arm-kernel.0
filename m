From: robert.richter@amd.com (Robert Richter)
Date: Wed, 1 Sep 2010 15:07:48 +0200
Subject: [PATCH] oprofile, x86: fix init_sysfs error handling
In-Reply-To: <20100901095117.GA4246@elte.hu>
References: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
	<1283107921-21464-2-git-send-email-will.deacon@arm.com>
	<1283107921-21464-3-git-send-email-will.deacon@arm.com>
	<1283107921-21464-4-git-send-email-will.deacon@arm.com>
	<20100830090929.GU22783@erda.amd.com>
	<1283244880.645.17.camel@e102144-lin.cambridge.arm.com>
	<20100831090518.GZ22783@erda.amd.com>
	<1283247089.4063.2.camel@e102144-lin.cambridge.arm.com>
	<20100831103001.GC22783@erda.amd.com>
	<20100901095117.GA4246@elte.hu>
Message-ID: <20100901130748.GK22783@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.09.10 05:51:17, Ingo Molnar wrote:
> > @@ -774,7 +781,10 @@ int __init op_nmi_init(struct oprofile_operations *ops)
> >  
> >  	mux_init(ops);
> >  
> > -	init_sysfs();
> > +	ret = init_sysfs();
> 
> FYI, this causes a build error if CONFIG_PM is off:
> 
>    arch/x86/oprofile/nmi_int.c:784: error: expected expression before ?do?
> 
> Due to this assymetric form of the wrapper:
> 
>   #define init_sysfs() do { } while (0)
> 
> The wrapper should be changed to return 0 i suspect, via something like 
> this:
> 
>   static inline int init_sysfs(void) { return 0; }
> 
> (untested)

Ingo, thanks for catching this, fix below.

-Robert

--
