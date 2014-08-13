From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Wed, 13 Aug 2014 10:19:08 +0200
Subject: [PATCH V2] arm64: optimized copy_to_user and copy_from_user
 assembly code
In-Reply-To: <53EAD7C8.7070001@linaro.org>
References: <1407538940-9167-1-git-send-email-fkan@apm.com>	<CAC8NTUXb1JmHwMLjmJtEKXjb+xYtuO4qKnSqMRWwACs35P8_HA@mail.gmail.com>
 <CAL85gmChQCM3iw-xqy-bkGRWH0jDvGf7v-GnxynS4HoOkL-cwQ@mail.gmail.com>
 <53EAD7C8.7070001@linaro.org>
Message-ID: <ADD43F5F-DFD2-4EF5-B5F9-65EDAF6B34AE@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Feng & Zhichang,

On 13 Aug 2014, at 05:13 , zhichang.yuan <zhichang.yuan@linaro.org> wrote:

> If the both dst and src are not aligned and their alignment offset are not equal, i haven't found better way
> to handle.
> But it is lucky ARMv8 support the non-align memory access.
> At the beginning of my patch work, i also think maybe it is more better that all load or store are aligned. I
> wrote the code just like the ARMv7 memcpy, firstly loaded the data from SRC and buffered them in several
> registers and combined as a new word( 16 bytes), then stored it to the aligned DST. But the performance is a
> bit worst.

When looking at the underlying effects in the execution pipeline, the store-operations are non-critical for the throughput and we need to optimize for optimal throughput on the load-operations. This is because the store operations have no dependent operations and the store-pipeline will take care of any lingering effects from the misalignment (given that mechanisms like write-allocate make cache-effects on the store-operations more difficult to predict, I?m glad we don?t have to go into too much detail on those), as there are no throughput/bandwidth limits on the store-pipeline that we could even theoretically hit with such a loop.

The load-operations are much more critical in the context of what we try to achieve: as our progress through the loop depends on the load-operations getting their results, so we process the associated stores, we need to ensure optimal and deterministic throughput on those. As a misaligned load is likely to carry a penalty (e.g. on XGene it will typically carry a small penalty when crossing a cache line, especially if the second cache-line isn?t cached yet), we need to avoid misaligned loads.

If we would try to buffer data and then perform aligned stores, we?ll only introduce additional instructions and latency into our critical loop. 
At the same time?given what I wrote above misaligned store-operations being essentially free?there?s no benefit to be gained from the extra work required.

I hope this explains the observed behaviour somewhat better.

Cheers,
Philipp.
