From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Oct 2015 17:02:45 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <11817958.z9KtmeKzV7@wuerfel>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
Message-ID: <57854232.vMTrn4EgZx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 23:46:35 Arnd Bergmann wrote:
> On Tuesday 13 October 2015 22:38:12 Peter Zijlstra wrote:
> > A quick grep shows a large amount of trivial code that optimizers will
> > still happily throw away, but it should be verified that this does not
> > result in pointless code generation.
> 
> Indeed, I'm seeing a tiny code growth with ARM multi_v7_defconfig when
> my patch is applied, as the image (according to size -A) grows from
> 13740187 bytes to 13740283, all of it in .text of two drivers (i2c-core
> and three files of bluetooth.ko).


Did we actually reach any conclusion here? We still get the warnings
in the regulator code in linux-next, and I'd like to see either this
patch ("mutex: make mutex_lock_nested an inline function") or
"regulator: core: avoid unused variable warning" get merged.

We could also remove the two functions again, as they are still
unused and we are getting closer to the merge window.

	Arnd

> --- build/multi_v7_defconfig-before/vmlinux.o.size	2015-10-13 23:11:40.544389776 +0200
> +++ build/multi_v7_defconfig/vmlinux.o.size	2015-10-13 23:08:00.151043811 +0200
> @@ -1,6 +1,6 @@
>  build/multi_v7_defconfig/vmlinux.o  :
>  section                                                          size   addr
> -.text                                                         8219408      0
> +.text                                                         8219504      0
>  
> --- build/multi_v7_defconfig-before/net/bluetooth/bluetooth.ko.size	2015-10-13 23:11:40.704382038 +0200
> +++ build/multi_v7_defconfig/net/bluetooth/bluetooth.ko.size	2015-10-13 23:07:58.639116862 +0200
> @@ -1,7 +1,7 @@
>  build/multi_v7_defconfig/net/bluetooth/bluetooth.ko  :
>  section                       size   addr
>  .note.gnu.build-id              36      0
> -.text                       241512      0
> +.text                       241696      0
>  
> --- build/multi_v7_defconfig-before/drivers/i2c/i2c-core.o.size	2015-10-13 23:11:40.636385326 +0200
> +++ build/multi_v7_defconfig/drivers/i2c/i2c-core.o.size	2015-10-13 23:07:53.403369830 +0200
> @@ -1,6 +1,6 @@
>  build/multi_v7_defconfig/drivers/i2c/i2c-core.o  :
>  section                                                 size   addr
> -.text                                                  12112      0
> +.text                                                  12208      0
> 
> The code in question is 
> 
> a)
> 
> static ssize_t
> i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
>                         const char *buf, size_t count)
> {
> ...
>         mutex_lock_nested(&adap->userspace_clients_lock,
>                           i2c_adapter_depth(adap));
> ...
> }
> 
> and
> 
> b)
> 
> static inline void l2cap_chan_lock(struct l2cap_chan *chan)
> {                             
>         mutex_lock_nested(&chan->lock, atomic_read(&chan->nesting));
> }       
> 
> The first one has a small size impact but no performance change as it is only
> called during probe/release of i2c modules. The second one adds an extra
> pointer access (due to the volatile keyword in atomic_read()) for every
> caller of l2cap_chan_lock().
> 
