From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 4 Apr 2017 11:09:39 +0200
Subject: [PATCH v2 03/13] drm/meson: Add support for components
In-Reply-To: <e0a88828-3fab-1a3e-ed1e-7a91d94358d4@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
 <1490109950-21421-4-git-send-email-narmstrong@baylibre.com>
 <20170404085931.7sv3k7lwgt6klu37@phenom.ffwll.local>
 <e0a88828-3fab-1a3e-ed1e-7a91d94358d4@baylibre.com>
Message-ID: <20170404090939.tiozilv4zigmiglu@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 11:08:26AM +0200, Neil Armstrong wrote:
> On 04/04/2017 10:59 AM, Daniel Vetter wrote:
> > On Tue, Mar 21, 2017 at 04:25:40PM +0100, Neil Armstrong wrote:
> >> +static int meson_drv_probe(struct platform_device *pdev)
> >> +{
> >> +	struct component_match *match = NULL;
> >> +	struct device_node *np = pdev->dev.of_node;
> >> +	struct device_node *ep, *remote;
> >> +	int count = 0;
> >> +
> >> +	for_each_endpoint_of_node(np, ep) {
> >> +		remote = of_graph_get_remote_port_parent(ep);
> >> +		if (!remote || !of_device_is_available(remote))
> >> +			continue;
> >> +
> >> +		count += meson_probe_remote(pdev, &match, np, remote);
> >> +	}
> >> +
> >> +	/* If some endpoints were found, initialize the nodes */
> >> +	if (count) {
> > 
> > What if you have more than 1 endpoint described, but module load order
> > conspires against you to only initialize 1 at first?
> 
> As I understood, the component_bind_all() will fail until all modules are loaded
> even in wrong order, no ?
> I tested with multiple combinations and it worked like a charm... maybe I missed
> something here !

I misread your code, looks all fine.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
