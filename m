From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 07 Jun 2017 18:01:02 +0800
Subject: [PATCH v2 03/11] drm: sun4i: ignore swapped mixer<->tcon
 connection for DE2
In-Reply-To: <20170607093512.rfvpefmyskgjw3ik@flea.lan>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-4-icenowy@aosc.io>
 <20170607093512.rfvpefmyskgjw3ik@flea.lan>
Message-ID: <01A7F22E-C4FF-4B4B-A9BC-FF0C96B996B9@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?6?7? GMT+08:00 ??5:35:12, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Mon, Jun 05, 2017 at 12:01:41AM +0800, Icenowy Zheng wrote:
>> Some SoC's DE2 has two mixers. Defaultly the mixer0 is connected to
>> tcon0 and mixer1 is connected to tcon1; however by setting a bit
>> the connection can be swapped.
>> 
>> As we now hardcode the default connection, ignore the bonus endpoint
>for
>> the mixer's output and the TCON's input, as they stands for the
>swapped
>> connection.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>So, I'm still not quite sure what this patch exactly is supposed to be
>doing.
>
>You mention that the routing between the mixers and tcons can be
>changed, and that we need to ignore the TCON input...

Yes, from the TCON perspective, the connection from
mixer0 to TCON1 and from mixer 1 to TCON0 should be
ignored. And from the mixer perspective, the connections should
also be omitted when binding in sun4i_drv.c.

>
>> ---
>> Changes in v2:
>> - Change to use new endpoint reg definition.
>> 
>>  drivers/gpu/drm/sun4i/sun4i_drv.c  | 45 ++++++++++++++++++++++++++++
>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 61
>++++++++++++++++++++++++++++++++------
>>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
>>  3 files changed, 99 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c
>b/drivers/gpu/drm/sun4i/sun4i_drv.c
>> index f19100c91c2b..775eee82d8a9 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
>> @@ -178,6 +178,13 @@ static bool sun4i_drv_node_is_frontend(struct
>device_node *node)
>>  		of_device_is_compatible(node,
>"allwinner,sun8i-a33-display-frontend");
>>  }
>>  
>> +static bool sun4i_drv_node_is_swappable_de2_mixer(struct device_node
>*node)
>> +{
>> +	/* The V3s has only one mixer-tcon pair, so it's not listed here.
>*/
>> +	return of_device_is_compatible(node,
>"allwinner,sun8i-h3-de2-mixer0") ||
>> +		of_device_is_compatible(node, "allwinner,sun8i-h3-de2-mixer1");
>> +}
>> +
>>  static bool sun4i_drv_node_is_tcon(struct device_node *node)
>>  {
>>  	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
>> @@ -261,6 +268,44 @@ static int sun4i_drv_add_endpoints(struct device
>*dev,
>>  			}
>>  		}
>>  
>> +		/*
>> +		 * The second endpoint of the output of a swappable DE2 mixer
>> +		 * is the TCON after connection swapping.
>> +		 * Ignore it now, as we now hardcode mixer0->tcon0,
>> +		 * mixer1->tcon1 connection.
>> +		 */
>> +		if (sun4i_drv_node_is_swappable_de2_mixer(node)) {
>> +			struct device_node *remote_ep_node;
>> +			struct of_endpoint local_endpoint, remote_endpoint;
>> +
>> +			remote_ep_node = of_graph_get_remote_endpoint(ep);
>> +			if (!remote_ep_node) {
>> +				DRM_DEBUG_DRIVER("Couldn't get remote endpoint\n");
>> +				continue;
>> +			}
>> +
>> +			if (of_graph_parse_endpoint(ep, &local_endpoint)) {
>> +				DRM_DEBUG_DRIVER("Couldn't parse local endpoint\n");
>> +				of_node_put(remote_ep_node);
>> +				continue;
>> +			}
>> +
>> +			if (of_graph_parse_endpoint(remote_ep_node,
>> +						    &remote_endpoint)) {
>> +				DRM_DEBUG_DRIVER("Couldn't parse remote endpoint\n");
>> +				of_node_put(remote_ep_node);
>> +				continue;
>> +			}
>> +
>> +			if (local_endpoint.id != remote_endpoint.id) {
>> +				DRM_DEBUG_DRIVER("Endpoint is an unused connection for DE2
>mixer... skipping\n");
>> +				of_node_put(remote_ep_node);
>> +				continue;
>> +			}
>> +
>> +			of_node_put(remote_ep_node);
>> +		}
>> +
>>  		/* Walk down our tree */
>>  		count += sun4i_drv_add_endpoints(dev, match, remote);
>
>... yet this is not parsing the input at all, but only the output
>nodes.

Yes.

Mixers will have two output endpoints, but we will only use
the same id one and ignore the swapped one.

So does the situation of TCON input.

>
>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index d9791292553e..568cea0e5f8f 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -464,7 +464,8 @@ static int sun4i_tcon_init_regmap(struct device
>*dev,
>>   * requested via the get_id function of the engine.
>>   */
>>  static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv
>*drv,
>> -						   struct device_node *node)
>> +						   struct device_node *node,
>> +						   bool skip_bonus_ep)
>>  {
>>  	struct device_node *port, *ep, *remote;
>>  	struct sunxi_engine *engine;
>> @@ -478,6 +479,42 @@ static struct sunxi_engine
>*sun4i_tcon_find_engine(struct sun4i_drv *drv,
>>  		if (!remote)
>>  			continue;
>>  
>> +		if (skip_bonus_ep) {
>> +			struct device_node *remote_ep_node;
>> +			struct of_endpoint local_endpoint, remote_endpoint;
>> +
>> +			remote_ep_node = of_graph_get_remote_endpoint(ep);
>> +			if (!remote_ep_node) {
>> +				DRM_DEBUG_DRIVER("Couldn't get remote endpoint\n");
>> +				of_node_put(remote);
>> +				continue;
>> +			}
>> +
>> +			if (of_graph_parse_endpoint(ep, &local_endpoint)) {
>> +				DRM_DEBUG_DRIVER("Couldn't parse local endpoint\n");
>> +				of_node_put(remote);
>> +				of_node_put(remote_ep_node);
>> +				continue;
>> +			}
>> +
>> +			if (of_graph_parse_endpoint(remote_ep_node,
>> +						    &remote_endpoint)) {
>> +				DRM_DEBUG_DRIVER("Couldn't parse remote endpoint\n");
>> +				of_node_put(remote);
>> +				of_node_put(remote_ep_node);
>> +				continue;
>> +			}
>> +
>> +			if (local_endpoint.id != remote_endpoint.id) {
>> +				DRM_DEBUG_DRIVER("Skipping bonus mixer->TCON connection when
>searching engine\n");
>> +				of_node_put(remote);
>> +				of_node_put(remote_ep_node);
>> +				continue;
>> +			}
>> +
>> +			of_node_put(remote_ep_node);
>> +		}
>> +
>
>I have no idea what this is supposed to be doing either.
>
>I might be wrong, but I really feel like there's a big mismatch
>between your commit log, and what you actually implement.
>
>In your commit log, you should state:
>
>A) What is the current behaviour
>B) Why that is a problem
>C) How do you address it
>
>And you don't.
>
>However, after discussing it with Chen-Yu, it seems like you're trying
>to have all the mixers probed before the TCONs. If that is so, there's
>nothing specific to the H3 here, and we also have the same issue on
>dual-pipeline DE1 (A10, A20, A31). Chen-Yu worked on that a bit, but
>the easiest solution would be to move from a DFS algorithm to walk
>down the graph to a BFS one.
>
>That way, we would add all mixers first, then the TCONs, then the
>encoders, and the component framework will probe them in order.

No. I said that they're swappable, however, I don't
want to implement the swap now, but hardcode 0-0 1-1
connection. However, as you and Chen-Yu said, device tree
should reflect the real hardware, there will be bonus endpoints
for the swapped connection.

What I want to do is to ignore the bonus connection, in order to
prevent them from confusing the code.

If you just change the bind sequence, I think it cannot be
prevented that wrong connections will be bound.

>
>Maxime
