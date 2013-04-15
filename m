From: a.spyridakis@virtualopensystems.com (Alexander Spyridakis)
Date: Mon, 15 Apr 2013 16:53:15 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <516C0E2A.40809@linaro.org>
References: <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
 <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
 <516BCAD0.9000708@linaro.org>
 <CAJRNFKJoBzgt4UhxsH65_LyhcGXPnzB_pg3q-zeYT2OVv59q4A@mail.gmail.com>
 <516BFD13.1000400@linaro.org>
 <20130415134837.GI9827@mudshark.cambridge.arm.com>
 <516C0E2A.40809@linaro.org>
Message-ID: <CAJRNFKJsVFhymgTuKdwufTX_u0DbZBn+HdhRZkgSwjC3U3w=mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2013 16:26, Andre Przywara <andre.przywara@linaro.org> wrote:
> Mmh, still thinking about a nice way to get some information out of HYP mode. schedule_delayed_work() to monitor a memory address didn't work (too early?).
>
> But meanwhile I compared the A7 and A15 TRM 4.3.32 HSCTLR:
> Bit 21 is fixed 0 on A15, but fixed 1 on A7.
> Can someone confirm that this is not a typo?

The HSCTLR value, seemed sane for all cores and it was fixed (read
HSCTLR and SCTLR, ORs some bits and updates HSCTLR). If I remember
correctly, at the time I was testing it, all cores reported the same
value for SCTLR but in the case of the 3rd A7 it would crash as soon
as it would try to write on HSCTLR. If you want to continue execution
remove one of the isbs, of course the 3rd A7 will immediately hang
when you try to run a guest (the rest of the cores will operate
normally even when running a guest on them).

Regards.
