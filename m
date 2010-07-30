From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 30 Jul 2010 17:19:03 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <083DF309106F364B939360100EC290F80AC392ACFC@eu1rdcrdc1wx030.exi.nxp.com>
References: <20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
	<20100715095637.GF26212@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC392ACFC@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <AANLkTikzGpqPHs4pBZKc118LvywJ09GuzLkXPp2kMBdW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/30 Kevin Wells <kevin.wells@nxp.com>:

>> - ? ? id = amba_lookup(pcdrv->id_table, pcdev);
>> + ? ? do {
>> + ? ? ? ? ? ? ret = amba_get_enable_pclk(pcdev);
>> + ? ? ? ? ? ? if (ret)
>> + ? ? ? ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? ? ? ? ret = pcdrv->probe(pcdev, id);
>> + ? ? ? ? ? ? if (ret == 0)
>> + ? ? ? ? ? ? ? ? ? ? break;
>>
>> - ? ? return pcdrv->probe(pcdev, id);
>> + ? ? ? ? ? ? amba_put_disable_pclk(pcdev);
>
> Should the AMBA clock be disabled if the probe() fails?

Yes. This is the pclk for this one PrimeCell. It is first turned on,
then the driver attempts to probe and in case that fails there
obviously is no driver for this piece of silicon so why should it
be clocked?

Yours,
Linus Walleij
