From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 Jan 2016 17:28:29 -0800
Subject: [PATCH 2/3] pinctrl: qcom: Use platform_irq_count() instead of
 of_irq_count()
In-Reply-To: <CAJAp7OhNxTzsRSq7MHfBCbp3F+vaw6tS99eMBw8FbWLunudiKQ@mail.gmail.com>
References: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
 <1452129169-2014-3-git-send-email-sboyd@codeaurora.org>
 <CAJAp7OhNxTzsRSq7MHfBCbp3F+vaw6tS99eMBw8FbWLunudiKQ@mail.gmail.com>
Message-ID: <568DBF3D.7090701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/16 17:19, Bjorn Andersson wrote:
> On Wed, Jan 6, 2016 at 5:12 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> of_irq_count() is not an exported symbol (and it shouldn't be
>> used by platform drivers anyway) so use platform_irq_count()
>> instead. This allows us to make the qcom pinctrl drivers modular
>> again.
>>
> [..]
>> diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
>> index 3ddb4cc38f1c..37ae6b72ea35 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
>> @@ -758,16 +758,19 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
>>         struct pinctrl_pin_desc *pins;
>>         struct pm8xxx_mpp *pctrl;
>>         int ret;
>> -       int i;
>> +       int i, npins;
>>
>>         pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
>>         if (!pctrl)
>>                 return -ENOMEM;
>>
>>         pctrl->dev = &pdev->dev;
>> -       pctrl->npins = of_irq_count(pdev->dev.of_node);
>> -       if (!pctrl->npins)
>> +       npins = of_irq_count(pdev->dev.of_node);
> platform_irq_count(pdev)

Ouch. So many duplicates the odds were against me.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
