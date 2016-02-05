From: friesendrywall@gmail.com (Erik Friesen)
Date: Thu, 4 Feb 2016 22:08:35 -0500
Subject: SGTL5000 misc
In-Reply-To: <CAOMZO5BxFRzi3qJAK=xDGger_MK9GZhuM00ugo836PHK_zJKjQ@mail.gmail.com>
References: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
 <CAOMZO5BPNc1ncz6J8yhcBYywCVuTxKYMYhiNUt_Jq3LZsKdi+A@mail.gmail.com>
 <CAEuupiszxAj7JkJu-5ozqgEnTWkz9FQEpxN8dmEN+KtaV-76ww@mail.gmail.com>
 <CAOMZO5DhrzdVyTVPB3FNquV4rDQ8a0MQrsJMosVsUQN63hj1Ww@mail.gmail.com>
 <CAEuupiuoB7nMSc8Fbyort1rJd=ZhYc0zfJNkd=ckUYk1qd8Z7Q@mail.gmail.com>
 <CAOMZO5C4QUHnJr=pisnYWCYZ0zUt+7HO846aPQui0zcLyX0N-Q@mail.gmail.com>
 <CAEuupivdftoopCOX3f7KRbV9poKdjdD3s9hfcbgB2TYjHmrjvw@mail.gmail.com>
 <CAEuupit8pVdnehkZkZPmq1QBHaS0sUG4NFuVFX37dKHn18j7DQ@mail.gmail.com>
 <CAOMZO5BxFRzi3qJAK=xDGger_MK9GZhuM00ugo836PHK_zJKjQ@mail.gmail.com>
Message-ID: <CAEuupium67HD-sz+ViPx8-L4S0TsS-C8ZrX3po382r=E-9QYgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is another issue here, but when I have this connected to
external power, it won't start the card on every other boot.

With the code below, it seems to start every time.  If I don't skip,
it dies on #8, which is the write of 0x7060 to CHIP_ANA_POWER

This embeddedarm board supposedly power cycles the regulators, don't
know if that is a factor or not.  The board finishes powerup 0x4060,
but comes back on reboot at the reset value of 0x7060

static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
{
  int i, ret, val, index;
  int reg;
  for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
    val = sgtl5000_reg_defaults[i].def;
    index = sgtl5000_reg_defaults[i].reg;
    ret = regmap_read(sgtl5000->regmap, index, &reg);
    if (reg != val) {
      ret = regmap_write(sgtl5000->regmap, index, val);
    } else {
     printk(KERN_INFO "SGTL5000 probe skipped at %i with OE val of
%x\n", i, reg);
    }
  if (ret) {
    printk(KERN_WARNING "SGTL5000 probe failed at %i with OE val of
%x\n", i, reg);
    return ret;
    }
  }

  return 0;
}

On Wed, Feb 3, 2016 at 5:20 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Feb 3, 2016 at 8:05 PM, Erik Friesen <friesendrywall@gmail.com> wrote:
>> Anyway, I think something like this should be added to sgtl5000.c
>
> Yes, please send a formal patch for it.
