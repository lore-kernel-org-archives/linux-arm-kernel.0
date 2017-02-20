From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 20 Feb 2017 00:47:57 -0800
Subject: [PATCH] arm64: traps: Mark __le16, __le32,
 __user variables properly
In-Reply-To: <20170219015808.2vc2kvpde7nlrey4@macbook.local>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
 <20170219015808.2vc2kvpde7nlrey4@macbook.local>
Message-ID: <148758047729.2988.16966413648865610904@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Luc Van Oostenryck (2017-02-18 17:58:09)
> On Fri, Feb 17, 2017 at 08:51:12AM -0800, Stephen Boyd wrote:
>  
> > Mark the types appropriately, and force the cast in get_user()
> > when assigning to 0 so sparse doesn't complain.
> I didn't looked deeply at this one but I don't think it is needed.
> Care to give more details?

I think my sparse is old. I was using v0.5.0 from my distro, but using
sparse-next branch from git.kernel.org doesn't show the problem anymore.
I suppose I'll upgrade this machine's sparse version manually to avoid
this problem in the future and withdraw my other patch to asm-generic.

> 
> 
> > Noticed while making other changes to this file. There are other issues still
> > about marking symbols static, but I'm not sure we want to introduce another
> > header file for the asmlinkage functions?
> Probably not, indeed.
> 
> > arch/arm64/kernel/traps.c:567:10: warning: Initializer entry defined twice
> > arch/arm64/kernel/traps.c:568:10:   also defined here
> This one I find strange. Can you tell which are those two entries?
> 

This is:

 static const char *esr_class_str[] = {
         [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
         [ESR_ELx_EC_UNKNOWN]            = "Unknown/Uncategorized",

where we initialize the entire array to an "unknown" value once, and
then fill in the known values after that. This isn't a very common
pattern, but it is used from time to time to avoid having lots of lines
to do the same thing.
