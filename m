From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 28 Jun 2018 11:51:06 +0100
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <cover.1530018818.git.andreyknvl@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
Message-ID: <20180628105057.GA26019@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 03:15:10PM +0200, Andrey Konovalov wrote:
> This patchset adds a new mode to KASAN [1], which is called KHWASAN
> (Kernel HardWare assisted Address SANitizer).
> 
> The plan is to implement HWASan [2] for the kernel with the incentive,
> that it's going to have comparable to KASAN performance, but in the same
> time consume much less memory, trading that off for somewhat imprecise
> bug detection and being supported only for arm64.
> 
> The overall idea of the approach used by KHWASAN is the following:
> 
> 1. By using the Top Byte Ignore arm64 CPU feature, we can store pointer
>    tags in the top byte of each kernel pointer.

[...]

This is a change from the current situation, so the kernel may be
making implicit assumptions about the top byte of kernel addresses.

Randomising the top bits may cause things like address conversions and
pointer arithmetic to break.

For example, (q - p) will not produce the expected result if q and p
have different tags.

Conversions, such as between pointer and pfn, may also go wrong if not
appropriately masked.

There are also potential pointer comparison and aliasing issues if
the tag bits are ever stripped or modified.


What was your approach to tracking down all the points in the code
where we have a potential issue?

(I haven't dug through the series in detail yet, so this may be
answered somewhere already...)

Cheers
---Dave
