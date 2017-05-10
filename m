From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 May 2017 11:48:31 +0200
Subject: [PATCH v5 1/9] phy: phy-mt65xx-usb3: improve RX detection stable
 time
In-Reply-To: <de1b9870-d325-e97a-a2f0-bd355c70356c@ti.com>
References: <1490945735-9531-1-git-send-email-chunfeng.yun@mediatek.com>
 <de1b9870-d325-e97a-a2f0-bd355c70356c@ti.com>
Message-ID: <75079f91-01f3-88ef-1733-5139857cc609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I took DTS parts for v4.12-next.
Sorry for the late response.
Matthias

On 06/04/17 12:28, Kishon Vijay Abraham I wrote:
> 
> 
> On Friday 31 March 2017 01:05 PM, Chunfeng Yun wrote:
>> The default value of RX detection stable time is 10us, and this
>> margin is too big for some critical cases which cause U3 link fail
>> and link to U2(probability is about 1%). So change it to 5us.
>>
> merged all the phy patches in this series to linux-phy -next.
> 
> Thanks
> Kishon
> 
>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
>>   drivers/phy/phy-mt65xx-usb3.c |   18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
>> index d972067..fe2392a 100644
>> --- a/drivers/phy/phy-mt65xx-usb3.c
>> +++ b/drivers/phy/phy-mt65xx-usb3.c
>> @@ -112,6 +112,14 @@
>>   #define P3D_RG_CDR_BIR_LTD0		GENMASK(12, 8)
>>   #define P3D_RG_CDR_BIR_LTD0_VAL(x)	((0x1f & (x)) << 8)
>>   
>> +#define U3P_U3_PHYD_RXDET1		(SSUSB_SIFSLV_U3PHYD_BASE + 0x128)
>> +#define P3D_RG_RXDET_STB2_SET		GENMASK(17, 9)
>> +#define P3D_RG_RXDET_STB2_SET_VAL(x)	((0x1ff & (x)) << 9)
>> +
>> +#define U3P_U3_PHYD_RXDET2		(SSUSB_SIFSLV_U3PHYD_BASE + 0x12c)
>> +#define P3D_RG_RXDET_STB2_SET_P3	GENMASK(8, 0)
>> +#define P3D_RG_RXDET_STB2_SET_P3_VAL(x)	(0x1ff & (x))
>> +
>>   #define U3P_XTALCTL3		(SSUSB_SIFSLV_SPLLC + 0x0018)
>>   #define XC3_RG_U3_XTAL_RX_PWD		BIT(9)
>>   #define XC3_RG_U3_FRC_XTAL_RX_PWD	BIT(8)
>> @@ -295,6 +303,16 @@ static void phy_instance_init(struct mt65xx_u3phy *u3phy,
>>   	tmp |= P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3);
>>   	writel(tmp, port_base + U3P_PHYD_CDR1);
>>   
>> +	tmp = readl(port_base + U3P_U3_PHYD_RXDET1);
>> +	tmp &= ~P3D_RG_RXDET_STB2_SET;
>> +	tmp |= P3D_RG_RXDET_STB2_SET_VAL(0x10);
>> +	writel(tmp, port_base + U3P_U3_PHYD_RXDET1);
>> +
>> +	tmp = readl(port_base + U3P_U3_PHYD_RXDET2);
>> +	tmp &= ~P3D_RG_RXDET_STB2_SET_P3;
>> +	tmp |= P3D_RG_RXDET_STB2_SET_P3_VAL(0x10);
>> +	writel(tmp, port_base + U3P_U3_PHYD_RXDET2);
>> +
>>   	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
>>   }
>>   
>>
