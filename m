From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Sep 2016 14:07:22 +0300
Subject: [PATCH v2 2/9] dmaengine: edma: Use enum for eDMA binding type
 (legacy vs TPCC)
In-Reply-To: <7753810.Z3F41qkFaI@wuerfel>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
 <20160921102637.24845-3-peter.ujfalusi@ti.com> <7753810.Z3F41qkFaI@wuerfel>
Message-ID: <bbd248d1-223c-00a9-3d2a-33df085c4f68@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/16 13:31, Arnd Bergmann wrote:
> On Wednesday, September 21, 2016 1:26:30 PM CEST Peter Ujfalusi wrote:
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index c2098a4b4dcf..4c8818278fcc 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -261,8 +261,11 @@ static const struct edmacc_param dummy_paramset = {
>>         .ccnt = 1,
>>  };
>>  
>> -#define EDMA_BINDING_LEGACY    0
>> -#define EDMA_BINDING_TPCC      1
>> +enum edma_binding_type {
>> +       EDMA_BINDING_LEGACY = 0,
>> +       EDMA_BINDING_TPCC,
>> +};



>> +
>>  static const struct of_device_id edma_of_ids[] = {
>>         {
>>                 .compatible = "ti,edma3",
>> @@ -2184,7 +2187,8 @@ static int edma_probe(struct platform_device *pdev)
>>                 const struct of_device_id *match;
>>  
>>                 match = of_match_node(edma_of_ids, node);
>> -               if (match && (u32)match->data == EDMA_BINDING_TPCC)
>> +               if (match &&
>> +                   (enum edma_binding_type)match->data == EDMA_BINDING_TPCC)
>>                         legacy_mode = false;
>>  
>>                 info = edma_setup_info_from_dt(dev, legacy_mode);
>> -- 
>> 2.10.0
>>
> 
> Are you sure this works on all architectures? IIRC the size of an enum
> is implementation defined, so this could still fail sometimes.

True, some arch have HW type for enum or something similar.

> 
> I tend to use 'uintptr_t' for the cast instead.

What about keeping the defines and:

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3e9606b08340..493fdf30e8b8 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -263,14 +263,19 @@ static const struct edmacc_param dummy_paramset = {

 #define EDMA_BINDING_LEGACY	0
 #define EDMA_BINDING_TPCC	1
+static const u32 edma_binding_type[] = {
+	[EDMA_BINDING_LEGACY] = EDMA_BINDING_LEGACY,
+	[EDMA_BINDING_TPCC] = EDMA_BINDING_TPCC,
+};
+
 static const struct of_device_id edma_of_ids[] = {
 	{
 		.compatible = "ti,edma3",
-		.data = (void *)EDMA_BINDING_LEGACY,
+		.data = (void *)&edma_binding_type[EDMA_BINDING_LEGACY],
 	},
 	{
 		.compatible = "ti,edma3-tpcc",
-		.data = (void *)EDMA_BINDING_TPCC,
+		.data = (void *)&edma_binding_type[EDMA_BINDING_TPCC],
 	},
 	{}
 };
@@ -2183,7 +2188,7 @@ static int edma_probe(struct platform_device *pdev)
 		const struct of_device_id *match;

 		match = of_match_node(edma_of_ids, node);
-		if (match && (u32)match->data == EDMA_BINDING_TPCC)
+		if (match && (*(u32*)match->data) == EDMA_BINDING_TPCC)
 			legacy_mode = false;

 		info = edma_setup_info_from_dt(dev, legacy_mode);


same for the ti-dma-crossbar.

-- 
P?ter
