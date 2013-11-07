From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Thu, 7 Nov 2013 03:01:02 +0000
Subject: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
In-Reply-To: <20131106100305.GI11602@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131106100305.GI11602@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828783E6@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The SGTL5000 is based on regulators and when it is disabled, there
> > will be an error returns directly while the SGTL5000 codec is probing.
> 
> What makes you say this?  
>

>From the code:
File path: "sound/soc/codecs/sgtl5000.c"
==================
#ifdef CONFIG_REGULATOR
.....
#else
static int ldo_regulator_register(struct snd_soc_codec *codec,
                                struct regulator_init_data *init_data,
                                int voltage)
{
        dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
        return -EINVAL;
}

static int ldo_regulator_remove(struct snd_soc_codec *codec)
{
        return 0;
}
#endif
-------------------

sgtl5000_probe() -->
sgtl5000_enable_regulators() -->
sgtl5000_replace_vddd_with_ldo() -->
ldo_regulator_register().


> That's not how the regulator API works.  Have
> you actually seen any problems?

There are some regulator APIs implemented by SGTL5000 driver, not the regulator subsystem APIs.
