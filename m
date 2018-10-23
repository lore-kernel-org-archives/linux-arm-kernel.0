From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Tue, 23 Oct 2018 17:44:32 +0530
Subject: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
In-Reply-To: <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org>
 <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk>
 <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org>
 <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
 <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
 <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
 <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
 <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
Message-ID: <CAFqt6zZ2yHkVcbYtK1dxr9B3K5WVYGboavjP1ibmYei0u4zFbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 6, 2018 at 4:19 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 6, 2018 at 7:11 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Fri, Oct 5, 2018 at 11:39 PM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > They are not supposed to be "steps". You did it with 70+ commits (!!)
> > > over the course of several months. Why a tree wasn't created, stuff
> > > developed there, and when done, submitted it for review?
> >
> > Because we already have a plan for entire vm_fault_t migration and
> > the * instruction * was to send one patch per driver.
>
> The instruction?

Sorry for the delayed response.
Instruction from Matthew  Wilcox who is supervising the entire vm_fault_t
migration work :-)

>
> > >
> > > Fine, but you haven't answered to the other parts of my email: you
> > > don't explain why you choose one alternative over the others, you
> > > simply keep changing the approach.
> >
> > We are going in circles here. That you want to convert vm_insert_page
> > to vmf_insert_page for the PF case is fine and understood. However,
> > you don't *need* to introduce a new name for the remaining non-PF
> > cases if the function is going to be the exact same thing as before.
> > You say "The final goal is to remove vm_insert_page", but you haven't
> > justified *why* you need to remove that name.
> >
> > I think I have given that answer. If we don't remove vm_insert_page,
> > future #PF caller will have option to use it. But those should be
> > restricted. How are we going to restrict vm_insert_page in one half
> > of kernel when other half is still using it  ?? Is there any way ? ( I don't
> > know)
>
> Ah, so that is what you are concerned about: future misuses. Well, I
> don't really see the problem. There are only ~18 calls to
> vm_insert_page() in the entire kernel: checking if people is using it
> properly for a while should be easy. As long as the new behavior is
> documented properly, it should be fine. If you are really concerned
> about mistakes being made, then fine, we can rename it as I suggested.
>
> Now, the new vm_insert_range() is another topic. It simplifies a few
> of the callers and buys us the rename at the same time, so I am also
> OK with it.
>
> As you see, I am not against the changes -- it is just that they
> should clearly justified. :-) It wasn't clear what your problem with
> the current vm_insert_page() is.
>
> Cheers,
> Miguel
