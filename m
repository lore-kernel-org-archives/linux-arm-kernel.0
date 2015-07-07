From: r.baldyga@hackerion.com (Robert Baldyga)
Date: Tue, 07 Jul 2015 18:00:27 +0200
Subject: [PATCH 1/5] usb: gadget: ffs: call functionfs_unbind() if
 _ffs_func_bind() fails
In-Reply-To: <20150707145345.GD4341@mwanda>
References: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
 <1436277773-14274-2-git-send-email-r.baldyga@samsung.com>
 <20150707145345.GD4341@mwanda>
Message-ID: <559BF79B.903@hackerion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2015 04:53 PM, Dan Carpenter wrote:
> On Tue, Jul 07, 2015 at 04:02:49PM +0200, Robert Baldyga wrote:
>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>> index 6e7be91..966b214 100644
>> --- a/drivers/usb/gadget/function/f_fs.c
>> +++ b/drivers/usb/gadget/function/f_fs.c
>> @@ -2897,11 +2897,19 @@ static int ffs_func_bind(struct usb_configuration *c,
>>   			 struct usb_function *f)
>>   {
>>   	struct f_fs_opts *ffs_opts = ffs_do_functionfs_bind(f, c);
>> +	struct ffs_function *func = ffs_func_from_usb(f);
>> +	int ret;
>>
>>   	if (IS_ERR(ffs_opts))
>>   		return PTR_ERR(ffs_opts);
>>
>> -	return _ffs_func_bind(c, f);
>> +	ret = _ffs_func_bind(c, f);
>> +	if (ret) {
>> +		ffs_opts->refcnt--;
>
> Wait, why are we decrementing here?  ffs_func_unbind() already has a
> decrement so this looks like a bug to me.  Add a comment if it's really
> needed.

Decrement is done in ffs_func_unbind() which is not called in this error 
path. But after all I see another problem here, because we shouldn't 
call functionfs_unbind() if refcnt after decrement is not equal zero. I 
will fix it.

>
>> +		functionfs_unbind(func->ffs);

Thanks,
Robert Baldyga
