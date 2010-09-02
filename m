From: ccross@google.com (Colin Cross)
Date: Thu, 2 Sep 2010 14:42:53 -0700
Subject: [PATCH] [ARM] tegra: Add i2c support
In-Reply-To: <AANLkTi=mC9jM7_U_KoAQ=Ec3Z5wefP-hii9M=_5ATo1i@mail.gmail.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
	<AANLkTi=mC9jM7_U_KoAQ=Ec3Z5wefP-hii9M=_5ATo1i@mail.gmail.com>
Message-ID: <AANLkTimqzUXNYFeG8pPiKxCr_4r+LDB4hwv7NW39edxy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 1:44 PM, Mike Rapoport <mike.rapoport@gmail.com> wrote:
> Hi Colin,
>
> On Fri, Jul 30, 2010 at 3:36 AM, Colin Cross <ccross@google.com> wrote:
>> +static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
>> + ? ? ? int num)
>> +{
>> + ? ? ? struct tegra_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
>> + ? ? ? int i;
>> + ? ? ? int ret = 0;
>> +
>> + ? ? ? if (i2c_dev->is_suspended)
>> + ? ? ? ? ? ? ? return -EBUSY;
>> +
>> + ? ? ? clk_enable(i2c_dev->clk);
>> + ? ? ? for (i = 0; i < num; i++) {
>> + ? ? ? ? ? ? ? int stop = (i == (num - 1)) ? 1 ?: 0;
>> + ? ? ? ? ? ? ? ret = tegra_i2c_xfer_msg(i2c_dev, &msgs[i], stop);
>> + ? ? ? ? ? ? ? if (ret)
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? }
>> + ? ? ? clk_disable(i2c_dev->clk);
>> + ? ? ? return i;
>
> In case of error the i2c_transfer should return the error code, so the
> return statement should be
> ? ? ? return ret ?: i;

Done
