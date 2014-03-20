From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Mar 2014 04:54:12 -0700
Subject: [PATCH 1/5] mtd: st_spi_fsm: Remove useless consts from function
 arguments
In-Reply-To: <1395316090.7776.24.camel@joe-AO722>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
 <1395313907-25318-2-git-send-email-lee.jones@linaro.org>
 <1395314713.7776.17.camel@joe-AO722>
 <20140320114123.GE21349@lee--X1>
 <1395316090.7776.24.camel@joe-AO722>
Message-ID: <20140320115412.GU31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 04:48:10AM -0700, Joe Perches wrote:
> On Thu, 2014-03-20 at 11:41 +0000, Lee Jones wrote:
> > On Thu, 20 Mar 2014, Joe Perches wrote:
> > > On Thu, 2014-03-20 at 11:11 +0000, Lee Jones wrote:
> > > > Reported-by: Brian Norris <computersforpeace@gmail.com>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > Why are these useless?
> > > 
> > > Even if the object code produced is the same,
> > > these serve as information to the human reader
> > > about how the arguments are used.
> > 
> > https://lkml.org/lkml/2014/3/20/69
> > 
> 
> From that email:
> 
> suggestion:
> 
> 	const uint8_t *const buf  => const uint8_t *buf
> 	const uint32_t size       => uint32_t size
> 	const uint32_t offset     => uint32_t offset
> 
> What was done:
> 
> -static int stfsm_write_fifo(struct stfsm *fsm,
> -                           const uint32_t *buf, const uint32_t size)
> +static int stfsm_write_fifo(struct stfsm *fsm, uint32_t *buf, uint32_t size)
> 
> Note the removal of the const from uint32_t *buf

Good catch. That wasn't my intention.

> Why?

I can let Lee speak for himself. But I'm thinking I'll squash this diff
in, if no one minds:

Signed-off-by: Brian Norris <computersforpeace@gmail.com>

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index bea1416aad07..1957d7c8e185 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -810,7 +810,8 @@ static void stfsm_read_fifo(struct stfsm *fsm, uint32_t *buf, uint32_t size)
 	}
 }
 
-static int stfsm_write_fifo(struct stfsm *fsm, uint32_t *buf, uint32_t size)
+static int stfsm_write_fifo(struct stfsm *fsm, const uint32_t *buf,
+			    uint32_t size)
 {
 	uint32_t words = size >> 2;
 
@@ -1806,7 +1807,7 @@ out1:
 	return ret;
 }
 
-static void stfsm_read_jedec(struct stfsm *fsm, uint8_t *const jedec)
+static void stfsm_read_jedec(struct stfsm *fsm, uint8_t *jedec)
 {
 	const struct stfsm_seq *seq = &stfsm_seq_read_jedec;
 	uint32_t tmp[2];
