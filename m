From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 15:24:22 +0000
Subject: [PATCH v2 08/13] mfd: Versatile Express system registers driver
In-Reply-To: <1347977875-16855-9-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-9-git-send-email-pawel.moll@arm.com>
Message-ID: <201209181524.22620.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Pawel Moll wrote:
> +The node describing a config device must refer to the sysreg node via
> +"arm,vexpress,config-bridge" phandle (can be also defined in the node's
> +parent) and relies on the board topology properties - see main vexpress
> +node documentation for more details. It must must also define the
> +following property:
> +- arm,vexpress-sysreg,func : must contain two cells:
> +  - first cell defines function number (eg. 1 for clock generator,
> +    2 for voltage regulators etc.)
> +  - device number (eg. osc 0, osc 1 etc.)
> +
> +Example:
> +       mcc {
> +               arm,vexpress,config-bridge = <&v2m_sysreg>;
> +
> +               osc at 0 {
> +                       compatible = "arm,vexpress-osc";
> +                       arm,vexpress-sysreg,func = <1 0>;
> +               };
> +       };

Why are you using a nonstandard property for the address?
AFAICT, the same can be expressed normally doing

       mcc {
	        #address-cells = <2>;
	 	#size-cells = <0>;
               arm,vexpress,config-bridge = <&v2m_sysreg>;

               osc at 0 {
                       compatible = "arm,vexpress-osc";
                       reg = <1 0>;
               };
       };

which is more in line with how we represent e.g. i2c buses.

	Arnd
