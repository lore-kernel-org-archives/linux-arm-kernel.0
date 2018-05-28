From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 28 May 2018 16:37:58 -0300
Subject: [PATCH] perf tools: Fix indexing for decoder packet queue
In-Reply-To: <CALZQ+UMbndvogrSb0Ey3ac1vDGqtsiRTR=ee8VGzU2Ni9_s0og@mail.gmail.com>
References: <1527289854-10755-1-git-send-email-mathieu.poirier@linaro.org>
 <CALZQ+UMbndvogrSb0Ey3ac1vDGqtsiRTR=ee8VGzU2Ni9_s0og@mail.gmail.com>
Message-ID: <20180528193758.GF25467@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, May 28, 2018 at 11:13:59AM +0800, Leo Yan escreveu:
> On Fri, May 25, 2018 at 05:10:54PM -0600, Mathieu Poirier wrote:
> > The tail of a queue is supposed to be pointing to the next available slot
> > in a queue.  In this implementation the tail is incremented before it is
> > used and as such points to the last used element, something that has the
> > immense advantage of centralizing tail management at a single location
> > and eliminating a lot of redundant code.
> >
> > But this needs to be taken into consideration on the dequeueing side where
> > the head also needs to be incremented before it is used, or the first
> > available element of the queue will be skipped.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index c8b98fa22997..4d5fc374e730 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -96,11 +96,19 @@ int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
> >   /* Nothing to do, might as well just return */
> >   if (decoder->packet_count == 0)
> >   return 0;
> > + /*
> > + * The queueing process in function cs_etm_decoder__buffer_packet()
> > + * increments the tail *before* using it.  This is somewhat counter
> > + * intuitive but it has the advantage of centralizing tail management
> > + * at a single location.  Because of that we need to follow the same
> > + * heuristic with the head, i.e we increment it before using its
> > + * value.  Otherwise the first element of the packet queue is not
> > + * used.
> > + */
> > + decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
> >
> >   *packet = decoder->packet_buffer[decoder->head];
> >
> > - decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
> > -
> 
> I tested this patch and confirmed it can work well with python
> decoding script:
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>

Ok, applying this patch, after having read Mathieu's response.

- Arnaldo
 
> Actually, I have another idea for this fixing, seems to me
> the unchanged code has right logic for decoder->head, and I think this
> issue is more related with incorrect initialization index.  So we can
> change the initialization index for decoder->head as below.  How about
> you think for this?
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index c8b98fa..b133260 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -249,7 +249,7 @@ static void cs_etm_decoder__clear_buffer(struct
> cs_etm_decoder *decoder)
>  {
>         int i;
> 
> -       decoder->head = 0;
> +       decoder->head = 1;
>         decoder->tail = 0;
>         decoder->packet_count = 0;
>         for (i = 0; i < MAX_BUFFER; i++) {
> 
> Thanks,
> Leo Yan
> 
> >   decoder->packet_count--;
> >
> >   return 1;
> > --
> > 2.7.4
> >
