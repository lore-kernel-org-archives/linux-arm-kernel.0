From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 06 Nov 2015 19:35:11 +0800
Subject: [PATCH v3 1/2] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <20151106104541.GC18409@sirena.org.uk>
References: <1446799162-15635-1-git-send-email-zhengsq@rock-chips.com>
 <1446799162-15635-2-git-send-email-zhengsq@rock-chips.com>
 <20151106104541.GC18409@sirena.org.uk>
Message-ID: <563C906F.8020502@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2015?11?06? 18:45, Mark Brown wrote:
> On Fri, Nov 06, 2015 at 04:39:21PM +0800, Shunqian Zheng wrote:
>
>> +	SOC_ENUM("Anti-pop", rk3036_codec_antipop_enum),
> As discussed this shouldn't be an enum.
Sure, I'll write the .get/.put/.info() for this.
Here is the preview of it.
Do you think the following is good to go?

static int rk3036_codec_antipop_info(struct snd_kcontrol *kcontrol,
                                      struct snd_ctl_elem_info *uinfo)
{
         uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
         uinfo->count = 2;
         uinfo->value.integer.min = 0;
         uinfo->value.integer.max = 1;

         return 0;
}

static int rk3036_codec_antipop_get(struct snd_kcontrol *kcontrol,
         struct snd_ctl_elem_value *ucontrol)
{
         struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
         int val, ret, regval;


         ret = snd_soc_component_read(component, INNO_R09, &regval);
         if (ret)
                 return ret;
         val = ((regval >> INNO_R09_HPL_ANITPOP_SHIFT) &
                INNO_R09_HP_ANTIPOP_MSK) == INNO_R09_HP_ANTIPOP_ON;
         ucontrol->value.integer.value[0] = val;

         val = ((regval >> INNO_R09_HPR_ANITPOP_SHIFT) &
                INNO_R09_HP_ANTIPOP_MSK) == INNO_R09_HP_ANTIPOP_ON;
         ucontrol->value.integer.value[1] = val;

         return 0;
}

static int rk3036_codec_antipop_put(struct snd_kcontrol *kcontrol,
         struct snd_ctl_elem_value *ucontrol)
{
         struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
         int val, ret, regmsk;

         val = (ucontrol->value.integer.value[0] ?
                INNO_R09_HP_ANTIPOP_ON : INNO_R09_HP_ANTIPOP_OFF ) <<
               INNO_R09_HPL_ANITPOP_SHIFT;
         val |= (ucontrol->value.integer.value[1] ?
                 INNO_R09_HP_ANTIPOP_ON : INNO_R09_HP_ANTIPOP_OFF ) <<
                INNO_R09_HPR_ANITPOP_SHIFT;

         regmsk = INNO_R09_HP_ANTIPOP_MSK << INNO_R09_HPL_ANITPOP_SHIFT |
                  INNO_R09_HP_ANTIPOP_MSK << INNO_R09_HPR_ANITPOP_SHIFT;

         ret = snd_soc_component_update_bits(component, INNO_R09,
                                             regmsk, val);
         if (ret < 0)
                 return ret;

         return 0;
}

#define SOC_RK3036_CODEC_ANTIPOP_DECL(xname) \
{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
         .info = rk3036_codec_antipop_info, .get = 
rk3036_codec_antipop_get, \
         .put = rk3036_codec_antipop_put, }


Thank you very much,
Shunqian
