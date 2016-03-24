From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Thu, 24 Mar 2016 23:09:28 +0800
Subject: [PATCH v2] cpufreq: rockchip: add driver
In-Reply-To: <20160324064324.GG22062@vireshk-i7>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
 <20160323044033.GQ5272@vireshk-i7> <56F35894.3020106@rock-chips.com>
 <20160324064324.GG22062@vireshk-i7>
Message-ID: <56F40328.5090001@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

can we add a of_match_table with a common compatible name as follows ?

--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -470,10 +470,16 @@ static int dt_cpufreq_remove(struct 
platform_device *pdev)
         cpufreq_unregister_driver(&dt_cpufreq_driver);
         return 0;
  }
+static const struct of_device_id dt_cpufreq_of_match[] = {
+       { .compatible = "***,***", },
+       { }
+};
+MODULE_DEVICE_TABLE(of, dt_cpufreq_of_match);
  static struct platform_driver dt_cpufreq_platdrv = {
         .driver = {
                 .name   = "cpufreq-dt",
+               .of_match_table = dt_cpufreq_of_match,
         },

--- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
+       cpufreq {
+               compatible = "***,***";
+       }

Does it create a DT node for a dummy device too ?


? 2016/3/24 14:43, Viresh Kumar ??:
> On 24-03-16, 11:01, Feng Xiao wrote:
>> hi all,
>>       I found that it could match the cpufreq-dt driver succesfully only with
>> the following changes.
>> --- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
>> @@ -139,6 +139,10 @@
>>                  };
>>          };
>>
>> +       cpufreq-dt {   //the node name must be cpufreq-dt
>> +               compatible = "rockchip,cpufreq";  //  the compatible name is
>> insignificant
>> +       };
>> +
> Its not allowed to create a DT node for a dummy device and so we never
> followed this way.
>
> I have just sent a patchset and cc'd you:
> "[PATCH 0/3] cpufreq: dt: Create platform device from generic code"
>
> and so this patch shall get replaced now.
>

-- 
Finley
