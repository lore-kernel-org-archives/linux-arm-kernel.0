From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 Sep 2013 17:38:38 +0530
Subject: [PATCH] dmaengine: sirf: add dmaengine_prep_slave_single/sg
 support
In-Reply-To: <CAJe_Zhfo0502tvd-0Rt-0kEKn+Z_S-B+JSAVd4=UNpneQ5GSvw@mail.gmail.com>
References: <1377435433-23202-1-git-send-email-Baohua.Song@csr.com>
 <20130826085607.GN2748@intel.com>
 <CAGsJ_4yhVFL+j9PV-srAXdYkbEN62X18n-_+cXa+xy4wcOF7Qw@mail.gmail.com>
 <20130902062549.GG7376@intel.com>
 <CAGsJ_4w4dNOy=8HMQqy9sCL=UVWXSgADjoqBD9FmSxdoyzZ6pQ@mail.gmail.com>
 <CAJe_Zhfo0502tvd-0Rt-0kEKn+Z_S-B+JSAVd4=UNpneQ5GSvw@mail.gmail.com>
Message-ID: <20130903120838.GG15824@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 05:25:40PM +0530, Jassi Brar wrote:
> > for example, if someone wants to do a 16Kbytes single transfer. how
> > will interleaved dma set transfer length and interval between every
> > row?
> > if it sets the transfer length to 16KB directly, the dma hardware
> > might not support such long a transfer at all.
> > so it might want to set as two 8KB transfer without interval between them.
> > 0~8KB                empty interval
> > 8KB-16KB          empty interval
> > or four 4KB transfer as
> > 0~4KB                empty interval
> > 4KB-8KB          empty interval
> > 8KB-12KB          empty interval
> > 12KB-16KB          empty interval
> >
> > the problem is we don't know the hardware limitation of every dma
> > controllers for transferring length of each row.
> >
> A client is only interested in transferring the total amount data and
> if/when it wants notified. How the dma controller divides the big
> transfer, shouldn't matter to the client. In fact it would be bad for
> a client to care about the working of a dma controller.
> IOW, the 16KB transfer could be divided into 4 parts by the dmac that
> supports max 4KB transfers, into 8 parts if max is 2KB and so on...
> the client shouldn't care.
That is also a correct approach. I agree that dma driver should be able to
handle any lengths and split that to multiple descriptors. 

But I think in interleaved API, clients should know the capablity otherwise dma
driver will have redo the whole list again...

~Vinod
-- 
