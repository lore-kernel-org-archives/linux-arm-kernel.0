From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 7 Apr 2015 05:12:33 +0200
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <20150407022312.GK18048@atomide.com>
References: <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com> <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
 <20150407022312.GK18048@atomide.com>
Message-ID: <20150407031233.GA16189@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 06, 2015 at 07:23:13PM -0700, Tony Lindgren wrote:
> I'm now thinking the kernel should just always set the 430973 specific
> cpu_v7_switch_mm for all cortex-a8 if IBE bit is set. That avoids
> the whole mess of early SoC detection and smc calls. And if IBE bit
> is not set, then we just use the regular cpu_v7_switch_mm.
>
> This will work as long as we can read the aux ctrl register IBE
> bit using mrc, which I believe is the case for all cortex-a8 based
> omap variants.

If I understood it correctly we can simply call the BTB flush on
cortex-a8 if IBE bit is not set, since it would be translated as
nop.

So it should be safe to include the call on all cortex-a8 based
cpus. We may need a non-BTB-flushing function for non-cortex-a8
based cpus, though.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150407/aec425aa/attachment.sig>
