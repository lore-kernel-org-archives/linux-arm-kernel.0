From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 4 Mar 2014 11:42:06 +0200
Subject: [PATCH 2/5] drivers: bus: omap_l3: Convert to use
 devm_request_and_ioremap()
In-Reply-To: <1393925000.716948505@f148.i.mail.ru>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
 <1393923710-10377-3-git-send-email-peter.ujfalusi@ti.com>
 <1393924359.866301359@f148.i.mail.ru> <1393925000.716948505@f148.i.mail.ru>
Message-ID: <53159FEE.3030801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 11:23 AM, Alexander Shiyan wrote:
>>> -	l3->l3_base[2] = ioremap(res->start, resource_size(res));
>>> -	if (!l3->l3_base[2]) {
>>> -		dev_err(&pdev->dev, "ioremap failed\n");
>>> -		ret = -ENOMEM;
>>> -		goto err2;
>>> +		l3->l3_base[i] = devm_request_and_ioremap(&pdev->dev, res);
>>> +		if (!l3->l3_base[i]) {
>>
>> if (IS_ERR(l3->l3_base[i]))
> 
> Ahh, I messed up this with devm_ioremap_resource().
> However, if there is reason to use devm_request_and_ioremap() here?

devm_request_and_ioremap() is just a wrapper for devm_ioremap_resource(). It
returns NULL in case of error (eats up the error code at the same time).
I don't have strong preference on this so I can change it to
devm_ioremap_resource()

-- 
P?ter
