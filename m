From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue,  2 Jan 2018 14:27:58 +0100
Subject: [PATCH 02/12] pinctrl: at91-pio4: account for const type of
 of_device_id.data
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1514899688-27844-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver creates a const structure that it stores in the data field
of an of_device_id array.

Adding const to the declaration of the location that receives the
const value from the data field ensures that the compiler will
continue to check that the value is not modified.  Furthermore, the
const-discarding cast on the extraction from the data field is no
longer needed.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/pinctrl-at91-pio4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -910,7 +910,7 @@ static int atmel_pinctrl_probe(struct pl
 	int i, ret;
 	struct resource	*res;
 	struct atmel_pioctrl *atmel_pioctrl;
-	struct atmel_pioctrl_data *atmel_pioctrl_data;
+	const struct atmel_pioctrl_data *atmel_pioctrl_data;
 
 	atmel_pioctrl = devm_kzalloc(dev, sizeof(*atmel_pioctrl), GFP_KERNEL);
 	if (!atmel_pioctrl)
@@ -924,7 +924,7 @@ static int atmel_pinctrl_probe(struct pl
 		dev_err(dev, "unknown compatible string\n");
 		return -ENODEV;
 	}
-	atmel_pioctrl_data = (struct atmel_pioctrl_data *)match->data;
+	atmel_pioctrl_data = match->data;
 	atmel_pioctrl->nbanks = atmel_pioctrl_data->nbanks;
 	atmel_pioctrl->npins = atmel_pioctrl->nbanks * ATMEL_PIO_NPINS_PER_BANK;
 
