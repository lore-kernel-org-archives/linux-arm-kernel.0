From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 Aug 2017 14:49:35 +0200
Subject: [PATCH 1/2] drm/bridge/sii8620: add external connector handle
In-Reply-To: <2097016.rlxulirhWA@avalon>
References: <1502371530-32260-1-git-send-email-m.purski@samsung.com>
 <6478480.TjcUCueU5y@avalon> <5ce6bd99-c50e-84c2-f21f-eb611cac94c2@samsung.com>
 <CGME20170811094031epcas5p4ca089af7dba2f3fafed757c1fb40c798@epcas5p4.samsung.com>
 <2097016.rlxulirhWA@avalon>
Message-ID: <9232b812-7aef-c614-b122-612e19743df4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 2017-08-11 11:40, Laurent Pinchart wrote:
> Hi Marek,
>
> On Friday 11 Aug 2017 08:39:31 Marek Szyprowski wrote:
>> On 2017-08-10 15:39, Laurent Pinchart wrote:
>>> On Thursday 10 Aug 2017 15:25:29 Maciej Purski wrote:
>>>> The driver should be switched on if an external connector is plugged and
>>>> switched off if it is unplugged. Extcon is optional. If it is not found,
>>>> the driver stays in "always-on" mode.
>>>>
>>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>>> ---
>>>>
>>>>    .../bindings/display/bridge/sil-sii8620.txt        |  4 ++
>>>>    drivers/gpu/drm/bridge/sil-sii8620.c               | 83 ++++++++++++++-
>>>>    2 files changed, 85 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
>>>> b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt index
>>>> 9409d9c..1f230bf 100644
>>>> --- a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
>>>> +++ b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
>>>> @@ -10,6 +10,9 @@ Required properties:
>>>>    	- clocks, clock-names: specification and name of "xtal" clock
>>>>    	- video interfaces: Device node can contain video interface port
>>>>    			    node for HDMI encoder according to [1].
>>>>
>>>> +Optional properties:
>>>> +	- extcon: phandle to external connector for MHL cable changes
>>>> +		  detection
>>> The sii8620 DT node should model its connection to the MHL connector using
>>> OF graph, connecting a port to the MHL connector DT node through
>>> endpoints. I believe the extcon property should then be added to the MHL
>>> connector DT node, not the bridge.
>> I don't get this. Generic extcon bindings doesn't define connector DT
>> node, so I don't see how could we use endpoint DT approach here. Could you
>> give the example?
> Sure, here you are.
>
> &hsi2c_7 {
> 	...
>
>          sii8620 at 39 {
>                  reg = <0x39>;
>                  compatible = "sil,sii8620";
>                  cvcc10-supply = <&ldo36_reg>;
>                  iovcc18-supply = <&ldo34_reg>;
>                  interrupt-parent = <&gpf0>;
>                  interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
>                  reset-gpios = <&gpv7 0 GPIO_ACTIVE_LOW>;
>                  clocks = <&pmu_system_controller 0>;
>                  clock-names = "xtal";
>
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
>
> 	                port at 0 {
> 				reg = <0>;
>          	                mhl_to_hdmi: endpoint {
>                  	                remote-endpoint = <&hdmi_to_mhl>;
> 	                        };
>          	        };
> 	                port at 1 {
> 				reg = <1>;
>          	                mhl_bridge_out: endpoint {
>                  	                remote-endpoint = <&mhl_connector_in>;
> 	                        };
>          	        };
> 		};
>          };
> };
>
> / {
> 	mhl-connector {
> 		compatible = "mhl-connector";
> 		extcon = <&muic>;
>
> 	        port {
>          	        mhl_connector_in: endpoint {
>                  	        remote-endpoint = <&mhl_bridge_out>;
> 	                };
>          	};
> 	};
> };
>
> Note that there's currently no DT binding for MHL connectors. One needs to be
> developed, the HDMI connector DT binding can be used as a source of
> inspiration.

Ah, I see. I wasn't aware that display subsystem has bindings even for 
the connectors.
Other types of connectors already used together with extcon in device 
tree (like usb
and chargers) don't have dedicated bindings.

Do we need to add hdmi-connectors to all existing boards that have HDMI 
module?

>>>>    [1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>>>>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
