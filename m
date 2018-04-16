From: rob@landley.net (Rob Landley)
Date: Mon, 16 Apr 2018 07:19:11 -0500
Subject: [PATCH] Replace unnecessary perl with sed, printf, and the shell
 $(( )) operator.
In-Reply-To: <20180416120930.GS16141@n2100.armlinux.org.uk>
References: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
 <20180416120930.GS16141@n2100.armlinux.org.uk>
Message-ID: <70d3e6cb-2ea3-1006-9af8-126cd3ea7fbb@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2018 07:09 AM, Russell King - ARM Linux wrote:
> On Wed, Apr 11, 2018 at 08:38:37PM -0500, Rob Landley wrote:
>> You can build a kernel in a cross compiling environment that doesn't have perl
>> in the $PATH. Commit 429f7a062e3b broke that for 32 bit arm. Fix it.
...
> This looks more complicated than necessary, and therefore less readable.
> What's wrong with:
> 
> KBSS_SZ := $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> 		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
> 		       -e 's/^\([^ ]*\) B __bss_stop$$/+0x\1/p') ))
> 
> The sed command produces output such as:
> 
> -0xc0955e58
> +0xc10b0f9c
> 
> which the shell is then able to evaluate and produce a decimal number.
> This seems to work fine with both bash and dash.

Yes, that is better.

Acked-by: Rob Landley <rob@landley.net>

Thanks,

Rob
