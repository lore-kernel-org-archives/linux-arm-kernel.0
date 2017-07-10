From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Jul 2017 07:21:40 +0200
Subject: [PATCH] ARM: tegra: Register host1x node with iommu binding on
 tegra124
In-Reply-To: <20170709163614.6746-1-contact@paulk.fr>
References: <20170709163614.6746-1-contact@paulk.fr>
Message-ID: <20170710052140.GA18089@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 09, 2017 at 07:36:14PM +0300, Paul Kocialkowski wrote:
> This registers the host1x node with the SMMU (as HC swgroup) to allow
> the host1x code to attach to it. It avoid failing the probe sequence,
> which resulted in the tegra drm driver not probing and thus nothing
> being displayed on-screen.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Thanks for tracking this down. However, I don't think this is an
appropriate fix for v4.12 because it requires an update to the DTB in
order to preserve functionality, which means we've broken DT ABI. The
proper fix I think needs to be to make usage of the IOMMU completely
optional in the host1x driver.

So I think what happens without this DT change is that the call to
iommu_attach_device() fails and we have no way to recover from that. I
think what we need to do is to free the domain in that case and make
sure we can continue without one. It's probably best to add an error
message, or maybe a warning to make sure people are aware.

Do you have the time to address this? If not, perhaps Mikko can take a
look?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/59e471ab/attachment.sig>
