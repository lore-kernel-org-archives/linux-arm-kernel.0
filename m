From: liguo.zhang@mediatek.com (liguo zhang)
Date: Sat, 16 Apr 2016 12:21:01 +0800
Subject: [PATCH v3] i2c: mediatek: i2c multi transfer optimization
In-Reply-To: <20160412211355.GA1526@katana>
References: <1457375031-3769-1-git-send-email-liguo.zhang@mediatek.com>
 <20160412211355.GA1526@katana>
Message-ID: <1460780461.29864.34.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-04-12 at 23:13 +0200, Wolfram Sang wrote:
> Hi,
> 
> thanks for the submission!
> 
> On Tue, Mar 08, 2016 at 02:23:51AM +0800, Liguo Zhang wrote:
> > Signal complete() in the i2c irq handler after one transfer done,
> > and then wait_for_completion_timeout() will return, this procedure
> > may cost much time, so only signal complete() when the entire
> > transaction has been completed, it will reduce the entire transaction
> > time.
> > 
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> 
> I wonder. You have less context switches, yes. On the other hand, you
> likely have bigger interrupt latency because you do more stuff in the
> interrupt handler. Is it really a gain in the end?
> 

When doing i2c multi transfer(first i2c write then i2c read, and not
using the MTK i2c WRRD mode) repeatedly in our stress test, we found the
procedure(complete()-->wait_for_completion_timeout()) may cost much
time, and it will affect the following i2c transfer. In our stress test,
It will affect the i2c read transfer, the value from the i2c read is not
right.
So when doing i2c multi transfer, the first is i2c write,then i2c read,
we will use the MTK i2c WRRD mode to do i2c multi transfer in the
previous patch.
But If i2c multi transfer has at least three transfer, we can't use the
MTK i2c WRRD mode, this patch may be important. Now we have not already
seen the i2c multi transfer scenario, which has at least three transfer.

> Regards,
> 
>    Wolfram
> 
