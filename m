From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Mon, 13 Oct 2014 10:16:06 +0200
Subject: [PATCH v3 6/8] phy: miphy28lp: Add SSC support for PCIE
In-Reply-To: <15685.1412018368@turing-police.cc.vt.edu>
References: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>
 <1411721657-9924-7-git-send-email-gabriel.fernandez@linaro.org>
 <15685.1412018368@turing-police.cc.vt.edu>
Message-ID: <CAG374jBJcX00S4nSugWXaUxAQV3Bwp+OxY0c2GJ-+rskzDzpGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valdis,
Thanks for your remark.

Concerning multiple writing in MIPHY_PLL_SBR_1, the writing of the
first 0 it's to be sure there is no previous request.
Then we take account new setting by writing 0x02.
And then we make it 0 to make sure there is no other pending requests.

I added comments and macro to be more clear (see the code below).


Hi Kishon,

Do you want a new patch set (v4),  or i wait other remarks from you ?


    for (val = 0; val < 2; val++) {
        writeb_relaxed(val, miphy_phy->base + MIPHY_CONF);

        /* Validate Step component */
        writeb_relaxed(0x69, miphy_phy->base + MIPHY_PLL_SBR_3);
        writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);

        /* Validate Period component */
        writeb_relaxed(0x3c, miphy_phy->base + MIPHY_PLL_SBR_2);
        writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);

        /* Clear any previous request */
        writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);

        /* requests the PLL to take in account new parameters */
        writeb_relaxed(SET_NEW_CHANGE, base + MIPHY_PLL_SBR_1);

        /* To be sure there is no other pending requests */
        writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
    }


Best regards

Gabriel.


On 29 September 2014 21:19,  <Valdis.Kletnieks@vt.edu> wrote:
> On Fri, 26 Sep 2014 10:54:15 +0200, Gabriel FERNANDEZ said:
>> SSC is the technique of modulating the operating frequency of a signal
>> slightly to spread its radiated emissions over a range of frequencies.
>> This reduction in the maximum emission for a given frequency helps meet
>> radiated emission requirements.
>> These settings are applicable for PCIE with Internal clock.
>
>> +             writeb_relaxed(0x69, miphy_phy->base + MIPHY_PLL_SBR_3);
>> +             writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);
>> +             writeb_relaxed(0x3c, miphy_phy->base + MIPHY_PLL_SBR_2);
>> +             writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);
>> +             writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
>> +             writeb_relaxed(0x02, miphy_phy->base + MIPHY_PLL_SBR_1);
>> +             writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
>
> I'd feel a lot better about all these magic numbers (and the triple write
> to SBR_1) if the Changelog or something referenced where they came from....
