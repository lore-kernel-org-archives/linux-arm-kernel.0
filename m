From: will.deacon@arm.com (Will Deacon)
Date: Sat, 12 Jul 2014 10:39:17 +0100
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <CAF6AEGv2P_Uq8CHgm1YdaUeMSNdH62ZwjLnT83Fr5GnxEAhTMw@mail.gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <CAF6AEGv2P_Uq8CHgm1YdaUeMSNdH62ZwjLnT83Fr5GnxEAhTMw@mail.gmail.com>
Message-ID: <20140712093917.GD18601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Jul 11, 2014 at 09:55:14PM +0100, Rob Clark wrote:
> On Fri, Jul 4, 2014 at 11:29 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> ok, so I was working through this to try to convert my
> {qcom,msm}-iommu-v0 RFC over to using these bindings.  For background,
> I was initially using something that looked a bit more like the
> current arm-smmu bindings:
> 
>         gpu {
>             #stream-id-cells = <16>;
>             ...
>         };
> 
>         gfx3d: qcom,iommu at 7c00000 {
>             compatible = "qcom,iommu-v0";
>             ...
>             mmu-masters =
>                 /* gfx3d_user: */
>                 <&gpu 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>,
>                 /* gfx3d_priv: */
>                 <&gpu 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31>;
>         };
> 
>         gfx3d1: qcom,iommu at 7d00000 {
>             compatible = "qcom,iommu-v0";
>             ...
>             mmu-masters =
>                 /* gfx3d_user: */
>                 <&gpu 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>,
>                 /* gfx3d_priv: */
>                 <&gpu 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31>;
>         };
> 
> With my current arrangement, I have everything I need when the iommu
> device is probed to set up each of the context banks
> 
> This proposal inverts that relationship.  Which forces me to do a lot
> more (including DT parsing) on device attach.  Which I'm not a huge
> fan of.  Ie. if I even wanted to try to implement per-process
> pagetables for gpu without completely going behind the IOMMU API's
> back, I would want attach/detach to be as lightweight as possible.

I think we'd have to walk the entire device-tree at IOMMU probe time in
order to enumerate the masters, which sounds horrible... If we want to do
clever SMR allocation on the ARM SMMU (as I've been discussing with Olav),
we're going to need knowledge about *all* the valid Stream IDs in the system
before we can program *any* translations.

> Was there actually a good reason for having the device link to the
> iommu rather than the other way around?  How much would people hate it
> if I just ignore the generic bindings and use something that works for
> me instead.  I mean, it isn't exactly like there is going to be .dts
> re-use across different SoC's..  and at least with current IOMMU API
> some sort of of_get_named_iommu() API doesn't really make sense.

The thing is, if you end up ignoring the generic binding then we have two
IOMMUs using the same (ARM SMMU) binding and it begs the question as to
which is the more generic! I know we're keen to get this merged, but merging
something that people won't use and calling it generic doesn't seem ideal
either. We do, however, desperately need a generic binding.

Turning the question around; Thierry -- what are the issue in using
something like the ARM SMMU binding (master device IDs held in the IOMMU
node) for the nvidia IOMMU?

Will
