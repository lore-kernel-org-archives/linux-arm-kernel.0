From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Tue, 3 Nov 2015 09:36:38 -0500
Subject: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
In-Reply-To: <5597828.MPo2kL1TSa@wuerfel>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <4911273.Q2mbQ2gvpn@wuerfel> <20151103101217.GE3503@x1>
 <5597828.MPo2kL1TSa@wuerfel>
Message-ID: <20151103143636.GA8350@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 11:48:38AM +0100, Arnd Bergmann wrote:
> On Tuesday 03 November 2015 10:12:17 Lee Jones wrote:
> > > 
> > > I think a 'buswidth=<16>;' property in addition to 'compatible="syscon"'
> > > is more in line with what other subsystems do.
> > 
> > Perfect.
> > 
> 
> Just to clarify: I just checked the other DT bindings and it should
> actually be "bus-width", not "buswidth".

Actually, I need the set the three following values of regmap_config:
reg_bits, reg_stride, and val_bits.

I had the following mapping in mind:

@@ -69,6 +70,18 @@ static struct syscon *of_syscon_register(struct device_node *np)
         else if (of_property_read_bool(np, "little-endian"))
                syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
 
+       ret = of_property_read_u32(np, "reg-bits", &val);
+       if (!ret)
+               syscon_config.reg_bits = val;
+
+       ret = of_property_read_u32(np, "val-bits", &val);
+       if (!ret)
+               syscon_config.val_bits = val;
+
+       ret = of_property_read_u32(np, "reg-stride", &val);
+       if (!ret)
+               syscon_config.reg_stride = val;
+
        regmap = regmap_init_mmio(NULL, base, &syscon_config);
        if (IS_ERR(regmap)) {
                pr_err("regmap init failed\n");


Would you prefer other property names, like "reg-bus-width",
"val-bus-width", and "reg-stride"? Should I prefix them with "syscon,"?


	Damien
