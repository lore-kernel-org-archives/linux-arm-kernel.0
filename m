From: friesendrywall@gmail.com (Erik Friesen)
Date: Wed, 3 Feb 2016 17:05:14 -0500
Subject: SGTL5000 misc
In-Reply-To: <CAEuupivdftoopCOX3f7KRbV9poKdjdD3s9hfcbgB2TYjHmrjvw@mail.gmail.com>
References: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
 <CAOMZO5BPNc1ncz6J8yhcBYywCVuTxKYMYhiNUt_Jq3LZsKdi+A@mail.gmail.com>
 <CAEuupiszxAj7JkJu-5ozqgEnTWkz9FQEpxN8dmEN+KtaV-76ww@mail.gmail.com>
 <CAOMZO5DhrzdVyTVPB3FNquV4rDQ8a0MQrsJMosVsUQN63hj1Ww@mail.gmail.com>
 <CAEuupiuoB7nMSc8Fbyort1rJd=ZhYc0zfJNkd=ckUYk1qd8Z7Q@mail.gmail.com>
 <CAOMZO5C4QUHnJr=pisnYWCYZ0zUt+7HO846aPQui0zcLyX0N-Q@mail.gmail.com>
 <CAEuupivdftoopCOX3f7KRbV9poKdjdD3s9hfcbgB2TYjHmrjvw@mail.gmail.com>
Message-ID: <CAEuupit8pVdnehkZkZPmq1QBHaS0sUG4NFuVFX37dKHn18j7DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anyway, I think something like this should be added to sgtl5000.c

static int sgtl5000_enable_regulators(struct snd_soc_codec *codec) {
 int reg;
 int ret;
 int rev;
 int i;
 const u32 *property;
 int external_vddd = 0;
 int use_ext_vdd = 0;
 struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);

 for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
  sgtl5000->supplies[i].supply = supply_names[i];

 //allow dtb to select option to use vddd external per errata
 //VDDD-external = <1>;
 ++ property = of_get_property(codec->dev->of_node, "VDDD-external", NULL);
 ++ if(property != NULL){
 ++ dev_info(codec->dev, "DTB = use VDDD %x\n", *property);
 ++ use_ext_vdd = 1;
 ++ }
 ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
sgtl5000->supplies);
 if (!ret) {
  external_vddd = 1;
 } else {
  ret = sgtl5000_replace_vddd_with_ldo(codec);
 if (ret)
 return ret;
 }

 ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
  sgtl5000->supplies);
if (ret)
goto err_regulator_free;

/* wait for all power rails bring up */
udelay(10);

/*
* workaround for revision 0x11 and later,
* roll back to use internal LDO
*/

ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
if (ret)
goto err_regulator_disable;

rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;

--if (external_vddd && rev >= 0x11)
++if (external_vddd && rev >= 0x11 && !use_ext_vdd) {
/* disable all regulator first */

On Wed, Feb 3, 2016 at 10:11 AM, Erik Friesen <friesendrywall@gmail.com> wrote:
> There is no difference in code that I can tell between the two.  I am
> not asking to have this fixed, rather just some ideas on how I can
> implement this. If alsa-devel list is the preferred asking place, I'll
> go there.
>
> The riotboard used kernel 4.3.0-rc2-00019-gbcee19f with the same results.
>
> On Wed, Feb 3, 2016 at 9:51 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Wed, Feb 3, 2016 at 12:46 PM, Erik Friesen <friesendrywall@gmail.com> wrote:
>>> It appears sgtl5000.c is patched the same in my kernel as the commit mentioned.
>>>
>>> The problem the way I see it, is that there is no mechanism to deal
>>> with a reboot on the codec itself.
>>
>> There is no reset line nor reset command on the sgtl5000.
>>
>>> This alsa stuff has too many layers.  At least coming from a non os
>>> embedded angle it seems that way.
>>
>> I would suggest you to try 4.4.1 and if you still see an issue with
>> the codec, then report it back to the alsa-devel at alsa-project.org
>> list.
