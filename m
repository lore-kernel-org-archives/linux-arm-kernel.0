From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 15 Apr 2014 14:45:05 +0800
Subject: [PATCH v2 06/12] ARM: mcpm: change max clusters to 4
In-Reply-To: <alpine.LFD.2.11.1404102203590.980@knanqh.ubzr>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-7-git-send-email-haojian.zhuang@linaro.org>
 <20140410095650.GA5499@e103592.cambridge.arm.com>
 <alpine.LFD.2.11.1404102203590.980@knanqh.ubzr>
Message-ID: <CAD6h2NTH1ZGWSNPeEMaZ4Lf+4UFOhXFtJeX1NEXETeonc76DYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2014 10:39, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 10 Apr 2014, Dave Martin wrote:
>
>> On Tue, Apr 08, 2014 at 04:00:46PM +0800, Haojian Zhuang wrote:
>> > In order to support 4 clusters with 4 Cortex A15 Cores in each cluster,
>> > enlarge maximum clusters from 2 to 4 in MCPM.
>>
>> CC Nico on mcpm patches please.  I'm happy to be CC'd as well.
>
> Indeed.
>
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> > ---
>> >  arch/arm/include/asm/mcpm.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
>> > index 608516e..68f82cf 100644
>> > --- a/arch/arm/include/asm/mcpm.h
>> > +++ b/arch/arm/include/asm/mcpm.h
>> > @@ -20,7 +20,7 @@
>> >   * to consider dynamic allocation.
>> >   */
>> >  #define MAX_CPUS_PER_CLUSTER       4
>> > -#define MAX_NR_CLUSTERS            2
>> > +#define MAX_NR_CLUSTERS            4
>>
>> Because of the need for alignment to the biggest cacheline size in the
>> system, the MCPM low-level locking structures consume a non-trivial
>> amount of memory.
>>
>> Therefore, I'm not keen on the idea of simply increasing this #define
>> every time a platform appears with a larger number of clusters.
>> If hip04 is not built into the kernel, this just wastes memory.
>>
>> I'll leave it to Nico to decide whether we can increase the #define
>> to 4 or whether this needs a proper fix now.  Ideally, we would have
>> a way of choosing the maximum value required by the set of boards built
>> into the kernel, or switch to dynamic allocation.
>
> I think we should go with the ability to select a maximum based on the
> configured platforms. That could be as simple as having a
> CONFIG_MCPM_QUAD_CLUSTER symbol to be selected by those platforms that
> need it.
>

I'll set MAX_NR_CLUSTERS from Kconfig.

If BIG_LITTLE isn't enabled & HIP04 is enabled, MAX_NR_CLUSTERS could
be set to 4.
Otherwise, it's always 2. Since there're only 16 A15 cores in HiP04.

Regards
Haojian
