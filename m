From: beanhuo@micron.com (=?iso-2022-jp?B?QmVhbiBIdW8gGyRCcDlJTElMGyhCIChiZWFuaHVvKQ==?=)
Date: Tue, 25 Aug 2015 01:44:57 +0000
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
Message-ID: <A765B125120D1346A63912DDE6D8B6310BF47A26@NTXXIAMBX02.xacn.micron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>+	nor->read_reg = atmel_qspi_read_reg;
>+	nor->write_reg = atmel_qspi_write_reg;
>+	nor->read = atmel_qspi_read;
>+	nor->write = atmel_qspi_write;
>+	nor->erase = atmel_qspi_erase;
>+	nor->set_protocol = atmel_qspi_set_protocol;

This is very good, the structure of spi_nor should add a hook function to notify spi controller 
That spi nor transfer protocol already changed.

>+
>+	if (of_modalias_node(child, modalias, sizeof(modalias)) < 0) {
>+		err = -ENODEV;
>+		goto release_channel;
>+	}
>+
>+	err = of_property_read_u32(child, "spi-max-frequency", &aq->clk_rate);
>+	if (err < 0)
>+		goto release_channel;
>+
>+	err = atmel_qspi_init(aq);
>+	if (err)
>+		goto release_channel;
>+
>+	nor->dev->of_node = child;
>+	err = spi_nor_scan(nor, modalias, SPI_NOR_QUAD);
>		goto release_channel;
>+


.......

>static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)  {
 	return mtd->priv;
>@@ -944,6 +960,11 @@ static int micron_quad_enable(struct spi_nor *nor)
>		return ret;
> 	}
> 
>+	/* switch protocol to Quad CMD 4-4-4 */
>+	ret = spi_nor_set_protocol(nor, SPI_PROTO_4_4_4);
>+	if (ret)
>+		return ret;
>+

This make sense,from spi nor side,once its protocol being changed,
Mtd layer must notify this status to spi nor controller immediately,
And spi nor controller also should re-adjust its protocol.
Otherwise, following reading SR operation will fail. 

>
> 	ret = spi_nor_wait_till_ready(nor);
> 	if (ret)
> 		return ret;

If my ack has any value in here, feel free to add it.

Acked-by: Bean Huo <beanhuo@micron.com>
