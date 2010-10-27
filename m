From: tfransosi@gmail.com (Thiago Farina)
Date: Wed, 27 Oct 2010 14:25:44 -0200
Subject: [PATCH v2 1/2] regulator: add support for regulators on the
	ab8500 MFD
In-Reply-To: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <AANLkTinc50bzQawaoA_XfkLhJXjVjPWzxgbCJ40UnYwi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 12:09 PM, Sundar Iyer
<sundar.iyer@stericsson.com> wrote:
> +static int ab8500_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> + ? ? ? int regulator_id, ret;
> + ? ? ? struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
> +
> + ? ? ? regulator_id = rdev_get_id(rdev);
> + ? ? ? if (regulator_id >= AB8500_NUM_REGULATORS)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? ret = ab8500_read(info->ab8500, info->update_reg);
> + ? ? ? if (ret < 0) {
> + ? ? ? ? ? ? ? dev_dbg(rdev_get_dev(rdev),
> + ? ? ? ? ? ? ? ? ? ? ? "couldnt read 0x%x register\n", info->update_reg);
> + ? ? ? ? ? ? ? return ret;
> + ? ? ? }
> +
> + ? ? ? if (ret & info->mask)
> + ? ? ? ? ? ? ? return true;
> + ? ? ? else
> + ? ? ? ? ? ? ? return false;
> +}

Shouldn't be this returning 1 instead of true and 0 instead false
(since the return type is int not bool)?

Maybe like this?
return (ret & info->mask) ? 1: 0;
