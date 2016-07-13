From: weiyj_lk@163.com (weiyj)
Date: Wed, 13 Jul 2016 13:36:42 +0800 (CST)
Subject: [PATCH -next] spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()
In-Reply-To: <20160713045030.GI18237@samsunx.samsung>
References: <CGME20160712110926epcas1p13bbc88f5867d41d09d9b8c1172a7150b@epcas1p1.samsung.com>
 <1468321722-16568-1-git-send-email-weiyj_lk@163.com>
 <20160713045030.GI18237@samsunx.samsung>
Message-ID: <481c6f26.751d.155e2c1d661.Coremail.weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

At 2016-07-13 12:50:30, "Andi Shyti" <andi.shyti@samsung.com> wrote:
>Hi Wei,
>
>> Once a spi_master_get() call succeeds, we need an additional
>> spi_master_put() call to free the memory, otherwise we will
>> leak a reference to master. Fix by removing the unnecessary
>> spi_master_get() call.
>> 
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
>The patch doesn't have anything wrong, but what you write in the
>description is not what you are doing in the patch.
>
>There is no memory allocated in spi_master_get and nothing leaks.
>Besides master's resources are managed, so that there would
>not be any need to call spi_master_put().
>
>spi_master_put() has been, indeed, removed in this commit:
>91800f0e90050a4db4c77e940796f501e02af8be.
>

master allocated in spi_alloc_master() need device reference count to zero
to be freed.

The call sequence spi_alloc_master/spi_register_master/spi_unregister_master
is complete; it reduces the device reference count to zero, which results in
device memory being freed.

In commit 91800f0e90050a4db4c77e940796f501e02af8be, 
devm_spi_register_master() equal to spi_register_master() and auto call
spi_unregister_master() when remove. But  remove spi_master_put()
will cause the device reference count left no zero, since spi_master_get()
is callled at the begin of remove function already.

So I think we should either remove the spi_master_get() or add spi_master_put()
before return from remove function.

Regards,
Yongjun Wei
