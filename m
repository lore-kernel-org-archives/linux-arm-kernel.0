From: horms@verge.net.au (Simon Horman)
Date: Thu, 23 May 2013 10:39:08 +0900
Subject: [PATCH v4 1/7] ARM: shmobile: Define DT bindings for timer devices
In-Reply-To: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130523013908.GC22608@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 01:23:57PM +0200, Bastian Hecht wrote:
> The SH mobile series currently features 3 timer devices in the kernel:
> Compare Match Timer (CMT), Timer Unit (TMU) and MTU2. These devices
> share register layout characteristics amongst each that enable us to
> define common DT bindings for them.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v4: same. only patch 2 and 3 changed

As per my recent email regarding "ARM: shmobile: sh73a0: Add timer DT names
to clock list", I have dropped this patch which was previously queued-up
for v3.11.

> 
>  .../devicetree/bindings/timer/renesas,timer.txt    |   45 ++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,timer.txt b/Documentation/devicetree/bindings/timer/renesas,timer.txt
> new file mode 100644
> index 0000000..2c001bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/renesas,timer.txt
> @@ -0,0 +1,45 @@
> +* Renesas SH Mobile Timer
> +
> +Bindings for several timer devices from Renesas including CMT, TMU and MTU2.
> +
> +Required properties:
> +- compatible : Should be "renesas,{device}-timer",
> +  whereas device is "cmt", "tmu" or "mtu2".
> +- reg : Address and length of the register set for the device
> +- interrupts : Timer interrupt
> +- renesas,device-id : The ID of the timer device
> +- renesas,channel-id : The channel ID of the timer device
> +- renesas,source-quality : The viability to use this device as a free
> +  running clock. From 0 (do not use) to 10 (best possible clock).
> +- renesas,event-quality : The viability to use this device as an event
> +  generator. From 0 (do not use) to 10 (best possible clock).
> +
> +The properties renesas,{source,event}-quality reflect the situation that the
> +usability of the timer devices depend on the location within their SoCs. E.g.
> +the power domain affinty affects power management, some mux-ed lines might be
> +preferred to be assigned to other functions and other constraints.
> +
> +Example for CMT1 channel 0 on the R8A7740 SoC:
> +
> +	timer at e6138010 {
> +		compatible = "renesas,cmt-timer";
> +		interrupt-parent = <&intca>;
> +		reg = <0xe6138010 0xc>;
> +		interrupts = <0x0b00>;
> +		renesas,device-id = <1>;
> +		renesas,channel-id = <0>;
> +		renesas,source-quality = <3>;
> +		renesas,event-quality = <3>;
> +	};
> +
> +Example for TMU0 channel 1 on the SH7372 SoC:
> +	timer at fff60014 {
> +		compatible = "renesas,tmu-timer";
> +		interrupt-parent = <&intcs>;
> +		reg = <0xfff60014 0xc>;
> +		interrupts = <0xea0>;
> +		renesas,device-id = <0>;
> +		renesas,channel-id = <1>;
> +		renesas,source-quality = <4>;
> +		renesas,event-quality = <0>;
> +	};
> -- 
> 1.7.9.5
> 
