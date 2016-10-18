From: popcornmix@gmail.com (popcorn mix)
Date: Tue, 18 Oct 2016 15:54:02 +0100
Subject: [PATCH 4/5] staging/vchi: Add a TODO file of things I know we
 need to deal with.
In-Reply-To: <20161017194406.1080-5-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
 <20161017194406.1080-5-eric@anholt.net>
Message-ID: <CAEi1pCQHUm+W6s9JBRyZwzS749TBVsf7NKx907Nbo7qRiF4RJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 8:44 PM, Eric Anholt <eric@anholt.net> wrote:
>
> I've also left out VC-CMA, which appears to be about having Linux
> manage a CMA area that the firmware gets to make allocations out of.
> I'm not clear on if this is useful (the firmware's need for memory
> drops massively with vc4 present, and may drop even more depending on
> how we resolve dmabuf handling for camera and video decode)


VC-CMA allows unused memory from the gpu to be used as CMA on the
linux side in a dynamic way.
However it has always had some issues, so is not enabled by default.

The main reason for wanting the gpu side to have significant memory is
for textures used
by the gpu side 3D driver. In the vc4-kms-v3d driver world the
requirement for significant amounts
of gpu memory goes away.

For most camera and video decode usage, the default gpu_mem=64M is sufficient.

As such, I'd ignore VC-CMA upstream, and assume it will disappear
downstream eventually.

vc_mem is used by vcdbg to get gpu side addresses for debug features
(e.g. extracting gpu debug log and viewing its memory heaps and vchiq state).

vcsm is currently used for allocating arm accessible memory from the gpu.
It is used by mmal when in zero copy mode (typically enabled) and as Eric says,
is likely to be used for dmabuf allocation.
