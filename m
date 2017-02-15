From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 16:14:26 -0600
Subject: [PATCH v2 1/3] ARM: l2c: add pl310-no-sideband option
In-Reply-To: <20170207170929.29525-2-chris.brandt@renesas.com>
References: <20170207170929.29525-1-chris.brandt@renesas.com>
 <20170207170929.29525-2-chris.brandt@renesas.com>
Message-ID: <20170215221426.e3dk4zzmhgfuplti@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 12:09:27PM -0500, Chris Brandt wrote:
> If a PL310 is added to a system, but the sideband signals are not
> connected, some Cortex A9 optimizations cannot be used. In particular,
> enabling Full Line Zeros in the CA9 without sidebands connected will
> crash the system since the CA9 will expect the L2C to perform operations,
> yet the L2C never gets the commands.

I assume you are talking about just the AxUSER signals, not the 
AxCACHE signals too. That would be really broken. IIRC, the other AxUSER 
signals are just hints and no connection would not be a problem. This is 
the only one that requires coordination with enabling/disabling in the 
core. 

I think this should follow existing feature properties and explicitly 
disable the specific properties rather than have this indirection.

> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  arch/arm/mm/cache-l2x0.c                         | 9 +++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> index 917199f..85046d2 100644
> --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> @@ -90,6 +90,8 @@ Optional properties:
>  - arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
>    <1> (forcibly enable), property absent (OS specific behavior,
>    preferably retain firmware settings)
> +- arm,pl310-no-sideband : disable all features that require sideband signals to
> +  be connected between the CPU and L2 (PL310 only).
>  
>  Example:
>  
