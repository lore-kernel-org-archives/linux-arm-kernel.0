From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 20 Oct 2017 12:00:53 +0100
Subject: [PATCH 00/17] coresight: perf: TMC ETR backend support
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <4abc56ac-c266-9967-8323-4779d095c521@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/17 18:15, Suzuki K Poulose wrote:
> The TMC-ETR supports routing the Coresight trace data to the
> System memory. It supports two different modes in which the memory
> could be used.
> 
> 1) Contiguous memory - The memory is assumed to be physically
> contiguous.
> 
> 2) Scatter Gather list - The memory can be chunks of 4K pages,
> which are specified in a table of pointers which itself could be
> multiple 4K size pages.
> 
> To avoid the complications of the managing the buffer, this series
> adds a layer for managing the ETR buffer, which makes the best possibly
> choice based on what is available. The allocation can be tuned by passing
> in flags, existing pages (e.g, perf ring buffer) etc.
> 
> Towards supporting ETR Scatter Gather mode, we introduce a generic TMC
> scatter-gather table which can be used to manage the data and table pages.
> The table can be filled in the format expected by the Scatter-Gather
> mode.
> 
> The TMC ETR-SG mechanism doesn't allow starting the trace at non-zero
> offset (required by perf). So we make some tricky changes to the table
> at run time to allow starting at any "Page aligned" offset and then
> wrap around to the beginning of the buffer with very less overhead.
> See patches for more description.
> 
> The series also improves the way the ETR is controlled by different modes
> (sysfs vs. perf) by keeping mode specific data. This allows access
> to the trace data collected in sysfs mode, even when the ETR is
> operated in perf mode. Also with the transparent management of the
> buffer and scatter-gather mechanism, we can allow the user to
> request for larger trace buffers for sysfs mode. This is supported
> by providing a sysfs file, "buffer_size" which accepts a page aligned
> size, which will be used by the ETR when allocating a buffer.
> 
> Finally, it cleans up the etm perf sink callbacks a little bit and
> then adds the support for ETR sink. For the ETR, we try our best to
> use the perf ring buffer as the target hardware buffer, provided :
>   1) The ETR is dma coherent (since the pages will be shared with
>      userspace perf tool).
>   2) The perf is used in snapshot mode (The ETR cannot be stopped
>      based on the size of the data written hence we could easily
>      overwrite the buffer. We may be able to fix this in the future)
>   3) The ETR supports the Scatter-Gather mode.
> 
> If we can't use the perf buffers directly, we fallback to using
> software buffering where we have to copy the trace data back
> to the perf ring buffer.
> 

Just to be clear :

The perf tool doesn't support the perf AUX api for coresight. I have
used the perf tool from perf-OpenCSD [1] project to control the tracing.

[1] https://git.linaro.org/people/mathieu.poirier/coresight.git perf-opencsd-4.14-rc1


Suzuki
