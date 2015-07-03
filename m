From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 3 Jul 2015 10:46:11 -0400
Subject: [PATCH 2/4] hvc_dcc: don't ignore errors during initialization
In-Reply-To: <55947DCD.1020605@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
 <1435699387-32591-2-git-send-email-timur@codeaurora.org>
 <55947DCD.1020605@codeaurora.org>
Message-ID: <42D8621F-E36D-4F4F-9143-3F7773EC834E@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 1, 2015, at 7:54 PM, Stephen Boyd wrote:

>> 
>> +	/* Returns -1 if error */
>> +	ret = hvc_instantiate(0, 0, &hvc_dcc_get_put_ops);
>> +
>> +	return ret < 0 ? -ENODEV : 0;
> 
> Why not just return the value that hvc_instantiate returns? And maybe we
> should change those -1 in hvc_instantiate into -EPERM?

Well, I didn't want to change common HVC code.  I would have to change all the other drivers that call hvc_instatiate as well.  I agree that returning -1 is bad, but fixing that is something that should be done in another patch.

>> 
>> -	hvc_alloc(0, 0, &hvc_dcc_get_put_ops, 128);
>> -	return 0;
>> +	p = hvc_alloc(0, 0, &hvc_dcc_get_put_ops, 128);
>> +
>> +	return IS_ERR(p) ? PTR_ERR(p) : 0;
> 
> return PTR_ERR_OR_ZERO()?

Yes, thanks.  I'll change it.
