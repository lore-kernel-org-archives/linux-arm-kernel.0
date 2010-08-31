From: david-b@pacbell.net (David Brownell)
Date: Mon, 30 Aug 2010 20:42:49 -0700 (PDT)
Subject: gs_start_io() and gs_close()
In-Reply-To: <4C7C5B39.80307@syncadence.com>
Message-ID: <286573.7601.qm@web180311.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, the patch looks plausible and you say you've
tested it ...

Greg, can you add this to your queue?

I figure that we should try to collect a
few "Tested-By" attributions before including
this in the next merge window.

But, at worst, I'd expect bugs that can
be fixed by one of the submitters...

I can imagine how having stress tested this on
systems with relatively much memory (not really
tiny embedded hardware, except physically) could
have hidden such problems.


--- On Mon, 8/30/10, Jim Sung <jsung@syncadence.com> wrote:

> From: Jim Sung <jsung@syncadence.com>
> Subject: Re: gs_start_io() and gs_close()
> To: "David Brownell" <david-b@pacbell.net>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>



> Cc: "Igor Grinberg" <grinberg@compulab.co.il>, linux-usb at vger.kernel.org, "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>
> Date: Monday, August 30, 2010, 6:30 PM
> Hi Dave:
> 
> >>>? ? seems wrong.
> > 
> > 
> > Does it cause an actual problem though?? Back
> when
> 
> The short answer is "yes", but not in a way that is easily
> noticeable.
> 
> > that code was written and submitted, ISTR doing a
> > leak analysis and finding none on start_io() paths
> > or their cleanup siblings.? Did something change
> 
> OK, the USB gadget serial driver actually has a couple of
> problems.? On
> gs_open(), it always allocates and queues an additional
> QUEUE_SIZE (16)
> worth of requests, so with a loop like this:
> 
> ? ? i=1 ; while echo $i > /dev/ttyGS0 ; do let
> i++ ; done
> 
> eventually we run into OOM (Out of Memory).
> 
> Technically, it is not a leak as everything gets freed up
> when the USB
> connection is broken, but not on gs_close().
> 
> With a USB device/gadget controller driver that has limited
> resources
> (e.g., Marvell has a this MAX_XDS_FOR_TR_CALLS of 64 for
> transmit and
> receive), so even after 4
> 
> ? ? stty -F /dev/ttyGS0
> 
> we cannot transmit anymore.? We can still receive (not
> necessarily
> reliably) as now we have 16 * 4 = 64 descriptors/buffers
> ready, but the
> device is otherwise not usable.
> 
> Got the
> 0001-pxa168-Dequeue-all-pending-USB-Req-s-submitted-to-U.patch
> from Marvell on 8-27-10, but it still has problems, so I'm
> not going to
> post it here.
> 
> > since then?
> 
> I don't believe so.
> 
> > I don't recall problems being reported in this area
> > over the past several years, either...
> 
> My take is that unless you explicitly look for it, you are
> probably not
> going to notice this.
> 
> Anyway, I tried not to change too much and to follow the
> basic design,
> but you have to be the judge of that.? I ran through a
> handful of tests,
> and it seemed to behave much better now.? Here is the
> patch (against
> 2.6.28), and you can decide whatever you want to do with
> it.
> 
> Jim
> 
> Index: drivers/usb/gadget/u_serial.c
> ===================================================================
> --- drivers/usb/gadget/u_serial.c? ?
> ???(revision 10419)
> +++ drivers/usb/gadget/u_serial.c? ?
> ???(working copy)
> @@ -103,11 +103,15 @@
> ? ? ? ? wait_queue_head_t? ?
> ???close_wait;? ???/*
> wait for last close */
> 
> ? ? ? ? struct list_head? ?
> ? ? read_pool;
> +? ? ???int read_started;
> +? ? ???int read_allocated;
> ? ? ? ? struct list_head? ?
> ? ? read_queue;
> ? ? ? ? unsigned? ? ?
> ? ? ? ? ? n_read;
> ? ? ? ? struct
> tasklet_struct???push;
> 
> ? ? ? ? struct list_head? ?
> ? ? write_pool;
> +? ? ???int write_started;
> +? ? ???int write_allocated;
> ? ? ? ? struct gs_buf? ?
> ? ? ???port_write_buf;
> ? ? ? ? wait_queue_head_t? ?
> ???drain_wait;? ???/*
> wait while writes drain */
> 
> @@ -361,6 +365,9 @@
> ? ? ? ? ? ? ? ?
> struct usb_request? ? ? *req;
> ? ? ? ? ? ? ? ?
> int? ? ? ? ? ? ? ?
> ? ???len;
> 
> +? ? ? ? ? ?
> ???if (port->write_started >=
> QUEUE_SIZE)
> +? ? ? ? ? ? ? ?
> ? ? ???break;
> +
> ? ? ? ? ? ? ? ? req
> = list_entry(pool->next, struct usb_request, list);
> ? ? ? ? ? ? ? ? len
> = gs_send_packet(port, req->buf, in->maxpacket);
> ? ? ? ? ? ? ? ? if
> (len == 0) {
> @@ -394,6 +401,8 @@
> ? ? ? ? ? ? ? ?
> ? ? ? ? break;
> ? ? ? ? ? ? ? ? }
> 
> +? ? ? ? ? ?
> ???port->write_started++;
> +
> ? ? ? ? ? ? ? ? /*
> abort immediately after disconnect */
> ? ? ? ? ? ? ? ? if
> (!port->port_usb)
> ? ? ? ? ? ? ? ?
> ? ? ? ? break;
> @@ -415,7 +424,6 @@
>  {
> ? ? ? ? struct list_head? ?
> ? ? *pool = &port->read_pool;
> ? ? ? ? struct usb_ep? ?
> ? ? ???*out =
> port->port_usb->out;
> -? ? ???unsigned? ?
> ? ? ? ? ? ? started = 0;
> 
> ? ? ? ? while (!list_empty(pool)) {
> ? ? ? ? ? ? ? ?
> struct usb_request? ? ? *req;
> @@ -427,6 +435,9 @@
> ? ? ? ? ? ? ? ? if
> (!tty)
> ? ? ? ? ? ? ? ?
> ? ? ? ? break;
> 
> +? ? ? ? ? ?
> ???if (port->read_started >=
> QUEUE_SIZE)
> +? ? ? ? ? ? ? ?
> ? ? ???break;
> +
> ? ? ? ? ? ? ? ? req
> = list_entry(pool->next, struct usb_request, list);
> ? ? ? ? ? ? ? ?
> list_del(&req->list);
> ? ? ? ? ? ? ? ?
> req->length = out->maxpacket;
> @@ -444,13 +455,13 @@
> ? ? ? ? ? ? ? ?
> ? ? ? ? list_add(&req->list,
> pool);
> ? ? ? ? ? ? ? ?
> ? ? ? ? break;
> ? ? ? ? ? ? ? ? }
> -? ? ? ? ? ?
> ???started++;
> +? ? ? ? ? ?
> ???port->read_started++;
> 
> ? ? ? ? ? ? ? ? /*
> abort immediately after disconnect */
> ? ? ? ? ? ? ? ? if
> (!port->port_usb)
> ? ? ? ? ? ? ? ?
> ? ? ? ? break;
> ? ? ? ? }
> -? ? ???return started;
> +? ? ???return
> port->read_started;
>  }
> 
>  /*
> @@ -532,6 +543,7 @@
> ? ? ? ? ? ? ? ? }
>  recycle:
> ? ? ? ? ? ? ? ?
> list_move(&req->list, &port->read_pool);
> +? ? ? ? ? ?
> ???port->read_started--;
> ? ? ? ? }
> 
> ? ? ? ? /* Push from tty to ldisc; this
> is immediate with low_latency, and
> @@ -590,6 +602,7 @@
> 
> ? ? ? ?
> spin_lock(&port->port_lock);
> ? ? ? ? list_add(&req->list,
> &port->write_pool);
> +? ? ???port->write_started--;
> 
> ? ? ? ? switch (req->status) {
> ? ? ? ? default:
> @@ -611,7 +624,7 @@
> ? ? ? ?
> spin_unlock(&port->port_lock);
>  }
> 
> -static void gs_free_requests(struct usb_ep *ep, struct
> list_head *head)
> +static void gs_free_requests(struct usb_ep *ep, struct
> list_head *head, int *allocated)
>  {
> ? ? ? ? struct usb_request? ?
> ? *req;
> 
> @@ -619,25 +632,30 @@
> ? ? ? ? ? ? ? ? req
> = list_entry(head->next, struct usb_request, list);
> ? ? ? ? ? ? ? ?
> list_del(&req->list);
> ? ? ? ? ? ? ? ?
> gs_free_req(ep, req);
> +? ? ? ? ? ?
> ???if (allocated)
> +? ? ? ? ? ? ? ?
> ? ? ???(*allocated)--;
> ? ? ? ? }
>  }
> 
>  static int gs_alloc_requests(struct usb_ep *ep, struct
> list_head *head,
> -? ? ? ? ? ?
> ???void (*fn)(struct usb_ep *, struct
> usb_request *))
> +? ? ? ? ? ?
> ???void (*fn)(struct usb_ep *, struct
> usb_request *), int *allocated)
>  {
> ? ? ? ? int? ? ? ?
> ? ? ? ? ? ???i;
> ? ? ? ? struct usb_request? ?
> ? *req;
> +? ? ???int n = allocated ?
> QUEUE_SIZE - *allocated : QUEUE_SIZE;
> 
> ? ? ? ? /* Pre-allocate up to
> QUEUE_SIZE transfers, but if we can't
> ? ? ? ???* do quite that many
> this time, don't fail ... we just won't
> ? ? ? ???* be as speedy as we
> might otherwise be.
> ? ? ? ???*/
> -? ? ???for (i = 0; i <
> QUEUE_SIZE; i++) {
> +? ? ???for (i = 0; i < n; i++)
> {
> ? ? ? ? ? ? ? ? req
> = gs_alloc_req(ep, ep->maxpacket, GFP_ATOMIC);
> ? ? ? ? ? ? ? ? if
> (!req)
> ? ? ? ? ? ? ? ?
> ? ? ? ? return list_empty(head) ?
> -ENOMEM : 0;
> ? ? ? ? ? ? ? ?
> req->complete = fn;
> ? ? ? ? ? ? ? ?
> list_add_tail(&req->list, head);
> +? ? ? ? if (allocated)
> +? ? ? ? ? ? (*allocated)++;
> ? ? ? ? }
> ? ? ? ? return 0;
>  }
> @@ -664,14 +682,14 @@
> ? ? ? ???* configurations may
> use different endpoints with a given port;
> ? ? ? ???* and high speed vs
> full speed changes packet sizes too.
> ? ? ? ???*/
> -? ? ???status =
> gs_alloc_requests(ep, head, gs_read_complete);
> +? ? ???status =
> gs_alloc_requests(ep, head, gs_read_complete,
> &port->read_allocated);
> ? ? ? ? if (status)
> ? ? ? ? ? ? ? ?
> return status;
> 
> ? ? ? ? status =
> gs_alloc_requests(port->port_usb->in,
> &port->write_pool,
> -? ? ? ? ? ? ? ?
> ? ? ???gs_write_complete);
> +? ? ? ? ? ? ? ?
> ? ? ???gs_write_complete,
> &port->write_allocated);
> ? ? ? ? if (status) {
> -? ? ? ? ? ?
> ???gs_free_requests(ep, head);
> +? ? ? ? ? ?
> ???gs_free_requests(ep, head,
> &port->read_allocated);
> ? ? ? ? ? ? ? ?
> return status;
> ? ? ? ? }
> 
> @@ -683,8 +701,8 @@
> ? ? ? ? if (started) {
> ? ? ? ? ? ? ? ?
> tty_wakeup(port->port_tty);
> ? ? ? ? } else {
> -? ? ? ? ? ?
> ???gs_free_requests(ep, head);
> -? ? ? ? ? ?
> ???gs_free_requests(port->port_usb->in,
> &port->write_pool);
> +? ? ? ? ? ?
> ???gs_free_requests(ep, head,
> &port->read_allocated);
> +? ? ? ? ? ?
> ???gs_free_requests(port->port_usb->in,
> &port->write_pool, &port->write_allocated);
> ? ? ? ? ? ? ? ?
> status = -EIO;
> ? ? ? ? }
> 
> @@ -1323,8 +1341,11 @@
> ? ? ? ?
> spin_lock_irqsave(&port->port_lock, flags);
> ? ? ? ? if (port->open_count == 0
> && !port->openclose)
> ? ? ? ? ? ? ? ?
> gs_buf_free(&port->port_write_buf);
> -? ?
> ???gs_free_requests(gser->out,
> &port->read_pool);
> -? ?
> ???gs_free_requests(gser->out,
> &port->read_queue);
> -? ?
> ???gs_free_requests(gser->in,
> &port->write_pool);
> +? ?
> ???gs_free_requests(gser->out,
> &port->read_pool, NULL);
> +? ?
> ???gs_free_requests(gser->out,
> &port->read_queue, NULL);
> +? ?
> ???gs_free_requests(gser->in,
> &port->write_pool, NULL);
> +
> +? ? ???port->read_allocated =
> port->read_started = port->write_allocated =
> port->write_started = 0;
> +
> ? ? ? ?
> spin_unlock_irqrestore(&port->port_lock, flags);
>  }
> 
