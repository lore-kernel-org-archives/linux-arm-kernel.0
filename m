From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 25 Apr 2016 10:12:16 -0400 (EDT)
Subject: [PATCH 4/4] ARM: remove duplicate const qualifier
In-Reply-To: <20160425125809.GP32731@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net> <20160425103911.GO32731@imgtec.com>
 <4641918.pNBP5iAK01@wuerfel> <20160425125809.GP32731@imgtec.com>
Message-ID: <alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr 2016, Eric Engestrom wrote:

> On Mon, Apr 25, 2016 at 01:38:18PM +0200, Arnd Bergmann wrote:
> > Maybe say you you found it (llvm, sparse, coccinelle?), and why this
> > is causing a problem for anyone. If it's just unnecessary but not
> > harmful, I'd probably ignore the patch.
> 
> $ grep -rE '(^|\W)const(\s+\w+)+\s+const\s'
> 
> I just happened to notice some unnecessary const in our internal code,
> so I grep'ed for it in a couple big OSS projects to see how common it
> was. Since I found only a few, I decided to remove them, but like I said
> it just gets ignored by all the compilers I know, so there's absolutely
> no harm in leaving this dead code around.

Beware.

I added many of those exactly because gcc did not ignore them when 
compiling with LTO where the lack of a const qualifier to qualify the 
actual array content, and not only the reference to that content, 
generated build errors due to section mismatches from the __initconst 
annotation.

So this is a NAK from me unless you may confirm that LTO builds are 
unaffected by your changes.


Nicolas
